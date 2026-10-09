-- DRAFTLY SUPABASE SCHEMA
-- Run this in your Supabase SQL Editor if you want to deploy to a real Supabase instance.

-- 1. Enable UUID extension
create extension if not exists "uuid-ossp";

-- 2. Profiles / Brand Voices table
create table if not exists public.brand_profiles (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references auth.users(id) on delete cascade,
  name text not null,
  type text not null,
  industry text default '',
  description text default '',
  audience jsonb default '{}'::jsonb,
  voice jsonb default '{}'::jsonb,
  samples text default '',
  detected_characteristics text[] default array[]::text[],
  goals text[] default array[]::text[],
  preferred_platforms text[] default array[]::text[],
  preferred_content_types text[] default array[]::text[],
  is_default boolean default false,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- 3. Content Drafts table
create table if not exists public.drafts (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references auth.users(id) on delete cascade,
  profile_id uuid references public.brand_profiles(id) on delete set null,
  campaign_id uuid,
  idea text not null,
  platform text not null,
  goal text not null,
  format text not null,
  audience_summary text,
  hook text not null,
  caption text not null,
  hashtags text[] default array[]::text[],
  cta text not null,
  visual_concept text,
  script text[],
  strategy text,
  why_this_draft jsonb not null,
  adaptations jsonb not null,
  evaluation jsonb not null,
  brand_safety jsonb not null,
  status text default 'draft', -- draft, scheduled, published
  scheduled_for timestamptz,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- 4. Campaigns table
create table if not exists public.campaigns (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references auth.users(id) on delete cascade,
  name text not null,
  goal text not null,
  audience text not null,
  platforms text[] default array[]::text[],
  start_date date,
  end_date date,
  notes text default '',
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- 5. Content Planner table
create table if not exists public.planner_items (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references auth.users(id) on delete cascade,
  draft_id uuid references public.drafts(id) on delete set null,
  campaign_id uuid references public.campaigns(id) on delete set null,
  date date not null,
  platform text not null,
  content_type text not null,
  topic text not null,
  goal text not null,
  status text default 'Draft', -- Draft, Scheduled, Published
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- Enable Row Level Security (RLS)
alter table public.brand_profiles enable row level security;
alter table public.drafts enable row level security;
alter table public.campaigns enable row level security;
alter table public.planner_items enable row level security;

-- Policies
create policy "Users can manage their own profiles"
  on public.brand_profiles for all
  using (auth.uid() = user_id);

create policy "Users can manage their own drafts"
  on public.drafts for all
  using (auth.uid() = user_id);

create policy "Users can manage their own campaigns"
  on public.campaigns for all
  using (auth.uid() = user_id);

create policy "Users can manage their own planner items"
  on public.planner_items for all
  using (auth.uid() = user_id);

-- 6. Connected Social Accounts table (Meta/Instagram, etc.)
create table if not exists public.social_accounts (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references auth.users(id) on delete cascade not null,
  platform text not null, -- 'instagram'
  platform_user_id text not null, -- Instagram Business Account ID
  username text not null,
  name text default '',
  profile_picture_url text default '',
  access_token_encrypted text not null,
  token_expires_at timestamptz,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  unique (user_id, platform)
);

-- 7. Social Publishing History table
create table if not exists public.publishing_history (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references auth.users(id) on delete cascade not null,
  draft_id uuid references public.drafts(id) on delete set null,
  platform text not null, -- 'Instagram'
  platform_post_id text,
  permalink text,
  status text not null, -- 'DRAFT', 'PUBLISHING', 'PUBLISHED', 'FAILED'
  error_message text,
  caption text not null,
  media_url text,
  media_type text default 'IMAGE', -- 'IMAGE', 'VIDEO', 'REEL'
  published_at timestamptz default now(),
  created_at timestamptz default now()
);

-- Enable RLS for Social Tables
alter table public.social_accounts enable row level security;
alter table public.publishing_history enable row level security;

create policy "Users can manage their own social accounts"
  on public.social_accounts for all
  using (auth.uid() = user_id);

create policy "Users can manage their own publishing history"
  on public.publishing_history for all
  using (auth.uid() = user_id);


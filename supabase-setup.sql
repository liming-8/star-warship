-- ============================================================
-- 星空战舰 · 全体排行榜建表脚本
-- 使用方法：登录 Supabase → SQL Editor → 新建查询 → 粘贴本脚本 → Run
-- ============================================================

create table if not exists public.players (
  id uuid primary key default gen_random_uuid(),
  nickname text unique not null,          -- 玩家昵称（全局唯一）
  score integer not null default 0,       -- 历史最高分
  wave integer not null default 0,        -- 取得该分数时抵达的波次
  clear_time integer not null default 0,  -- 最快通关用时（秒），0 表示未通关
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- 开启行级安全（RLS）
alter table public.players enable row level security;

-- 公开可读：任何人都能查看全体排行榜
create policy "players_read" on public.players
  for select using (true);

-- 公开可插入：新玩家首次设置昵称时注册
create policy "players_insert" on public.players
  for insert with check (true);

-- 公开可更新：提交得分、修改昵称
create policy "players_update" on public.players
  for update using (true) with check (true);

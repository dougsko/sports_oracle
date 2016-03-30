CREATE TABLE "schema_migrations" ("version" varchar NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
CREATE TABLE "leagues" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "conferences" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "league_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_conferences_on_league_id" ON "conferences" ("league_id");
CREATE TABLE "divisions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "conference_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_divisions_on_conference_id" ON "divisions" ("conference_id");
CREATE TABLE "teams" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "short_name" varchar, "city" varchar, "division_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_teams_on_division_id" ON "teams" ("division_id");
CREATE TABLE "games" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "week" integer, "year" integer, "game_time" datetime, "away_team" varchar, "home_team" varchar, "away_city" varchar, "home_city" varchar, "away_name" varchar, "home_name" varchar, "away_line" decimal, "home_line" decimal, "away_score" integer, "home_score" integer, "away_ats_result" varchar, "home_ats_result" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "over_under" decimal, "over_under_result" varchar, "home_rush_yards" int, "away_rush_yards" int, "home_pass_yards" int, "away_pass_yards" int, "home_qb_rating" decimal, "away_qb_rating" decimal, "home_receptions" int, "away_receptions" int, "home_interceptions" int, "away_interceptions" int);
CREATE TABLE "stat_entries" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "week" integer, "year" integer, "team_id" integer, "value" decimal, "stat_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "rating" decimal, "rating_deviation" decimal, "volatility" decimal);
CREATE INDEX "index_stat_entries_on_stat_id" ON "stat_entries" ("stat_id");
CREATE TABLE "stats" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "predictive_power" decimal, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "home_compare_field" varchar, "away_compare_field" varchar, "win_prediction" int, "line_prediction" int);
CREATE TABLE "players" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "type" varchar, "first_name" varchar, "last_name" varchar, "full_name" varchar, "position" varchar, "number" integer, "status" varchar, "team_id" integer, "nfl_player_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "stat_lines" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "nfl_player_id" integer, "week" integer, "year" integer, "rush_atts" integer, "rush_yards" integer, "rush_tds" integer, "fumbles" integer, "pass_comp" integer, "pass_att" integer, "pass_yards" integer, "pass_tds" integer, "ints" integer, "qb_rating" decimal, "receptions" integer, "rec_yards" integer, "rec_tds" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "player_id" integer, "game_id" integer, "team_id" integer);
INSERT INTO schema_migrations (version) VALUES ('20151211175224');

INSERT INTO schema_migrations (version) VALUES ('20151211190230');

INSERT INTO schema_migrations (version) VALUES ('20151211203946');

INSERT INTO schema_migrations (version) VALUES ('20151211212327');

INSERT INTO schema_migrations (version) VALUES ('20151212040916');

INSERT INTO schema_migrations (version) VALUES ('20151212040924');

INSERT INTO schema_migrations (version) VALUES ('20151212203737');

INSERT INTO schema_migrations (version) VALUES ('20151214173144');

INSERT INTO schema_migrations (version) VALUES ('20151214205648');

INSERT INTO schema_migrations (version) VALUES ('20151217181529');

INSERT INTO schema_migrations (version) VALUES ('20151217182751');

INSERT INTO schema_migrations (version) VALUES ('20151217203559');

INSERT INTO schema_migrations (version) VALUES ('20151217203801');

INSERT INTO schema_migrations (version) VALUES ('20151217213914');

INSERT INTO schema_migrations (version) VALUES ('20151218153557');

INSERT INTO schema_migrations (version) VALUES ('20160318144346');

INSERT INTO schema_migrations (version) VALUES ('20160318151442');

INSERT INTO schema_migrations (version) VALUES ('20160318152245');

INSERT INTO schema_migrations (version) VALUES ('20160318154005');

INSERT INTO schema_migrations (version) VALUES ('20160318155802');

INSERT INTO schema_migrations (version) VALUES ('20160318164655');


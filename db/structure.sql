CREATE TABLE "event_types" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(60) NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE UNIQUE INDEX "index_event_types_on_name" ON "event_types" ("name");
CREATE TABLE "events" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "description" varchar(255), "event_date" date NOT NULL, "event_type_id" integer NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE UNIQUE INDEX "index_events_on_event_type_id_and_event_date" ON "events" ("event_type_id", "event_date");
CREATE INDEX "index_events_on_event_type_id" ON "events" ("event_type_id");
CREATE TABLE "languages" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(60) NOT NULL, "code" varchar(2) NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE UNIQUE INDEX "index_languages_on_code" ON "languages" ("code");
CREATE UNIQUE INDEX "index_languages_on_name" ON "languages" ("name");
CREATE TABLE "payment_types" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "frequency" integer, "amount" decimal, "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_payment_types_on_frequency" ON "payment_types" ("frequency");
CREATE UNIQUE INDEX "index_payment_types_on_name" ON "payment_types" ("name");
CREATE TABLE "payments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "description" varchar(255), "payment_date" date, "payment_type_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_payments_on_description" ON "payments" ("description");
CREATE INDEX "index_payments_on_payment_type_id" ON "payments" ("payment_type_id");
CREATE TABLE "person_event_relationships" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "person_id" integer NOT NULL, "event_id" integer NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_person_event_relationships_on_event_id" ON "person_event_relationships" ("event_id");
CREATE UNIQUE INDEX "index_person_event_relationships_on_person_id_and_event_id" ON "person_event_relationships" ("person_id", "event_id");
CREATE INDEX "index_person_event_relationships_on_person_id" ON "person_event_relationships" ("person_id");
CREATE TABLE "person_languages" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "language_id" integer NOT NULL, "person_id" integer NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE UNIQUE INDEX "index_person_languages_on_language_id_and_person_id" ON "person_languages" ("language_id", "person_id");
CREATE INDEX "index_person_languages_on_language_id" ON "person_languages" ("language_id");
CREATE INDEX "index_person_languages_on_person_id" ON "person_languages" ("person_id");
CREATE TABLE "person_payments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "person_id" integer NOT NULL, "payment_id" integer NOT NULL, "amount" decimal, "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_person_payments_on_payment_id" ON "person_payments" ("payment_id");
CREATE UNIQUE INDEX "index_person_payments_on_person_id_and_payment_id" ON "person_payments" ("person_id", "payment_id");
CREATE INDEX "index_person_payments_on_person_id" ON "person_payments" ("person_id");
CREATE TABLE "roles" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255) NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE UNIQUE INDEX "index_roles_on_name" ON "roles" ("name");
CREATE TABLE "statuses" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(60) NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_statuses_on_name" ON "statuses" ("name");
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
CREATE TABLE "departments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(60) NOT NULL, "description" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE UNIQUE INDEX "index_departments_on_name" ON "departments" ("name");
CREATE TABLE "department_person_roles" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "department_id" integer NOT NULL, "person_id" integer NOT NULL, "role_id" integer NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_department_person_roles_on_department_id" ON "department_person_roles" ("department_id");
CREATE INDEX "index_department_person_roles_on_person_id" ON "department_person_roles" ("person_id");
CREATE INDEX "index_department_person_roles_on_role_id" ON "department_person_roles" ("role_id");
CREATE UNIQUE INDEX "index_department_person_roles_department_id_person_id_role_id" ON "department_person_roles" ("department_id", "person_id", "role_id");
CREATE TABLE "app_setup_types" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(60) NOT NULL, "description" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "application_setups" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "app_setup_type_id" integer, "language_code_id" varchar(5) NOT NULL, "code_id" varchar(60) NOT NULL, "description" varchar(255), "str_value" varchar(255) NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_application_setups_on_app_setup_type_id" ON "application_setups" ("app_setup_type_id");
CREATE UNIQUE INDEX "index_application_setups_language_code_id_code_id" ON "application_setups" ("language_code_id", "code_id");
CREATE TABLE "people" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(60) NOT NULL, "family_name" varchar(60), "email" varchar(60), "phone_mob" varchar(60), "gender" integer, "id_card_number" varchar(9), "address" varchar(255), "admin" boolean DEFAULT 'f', "password_digest" varchar(255), "remember_token" varchar(255), "birth_date" date, "workplace" varchar(255), "skills" varchar(255), "phone_additional" varchar(60), "computer_knowledge" integer, "family_status" integer, "car_owner" integer, "created_at" datetime, "updated_at" datetime, "status_id" integer, "area" varchar(60), "car_number" varchar(60), "email_2" varchar(60), "org_relation_status_id" integer);
CREATE UNIQUE INDEX "index_people_on_email" ON "people" ("email");
CREATE INDEX "index_people_on_family_name" ON "people" ("family_name");
CREATE UNIQUE INDEX "index_people_on_id_card_number" ON "people" ("id_card_number");
CREATE INDEX "index_people_on_name" ON "people" ("name");
CREATE INDEX "index_people_on_remember_token" ON "people" ("remember_token");
CREATE INDEX "index_people_on_status_id" ON "people" ("status_id");
CREATE TABLE "org_relation_statuses" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(60) NOT NULL, "description" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE UNIQUE INDEX "index_org_relation_statuses_on_name" ON "org_relation_statuses" ("name");
CREATE INDEX "index_people_on_org_relation_status_id" ON "people" ("org_relation_status_id");
INSERT INTO schema_migrations (version) VALUES ('20140403055712');

INSERT INTO schema_migrations (version) VALUES ('20140404060000');

INSERT INTO schema_migrations (version) VALUES ('20140404075359');

INSERT INTO schema_migrations (version) VALUES ('20140420060051');

INSERT INTO schema_migrations (version) VALUES ('20140504065446');

INSERT INTO schema_migrations (version) VALUES ('20140519164544');

INSERT INTO schema_migrations (version) VALUES ('20140519172800');

INSERT INTO schema_migrations (version) VALUES ('20140520031649');

INSERT INTO schema_migrations (version) VALUES ('20140520142833');

INSERT INTO schema_migrations (version) VALUES ('20140521031109');

INSERT INTO schema_migrations (version) VALUES ('20140521031725');

INSERT INTO schema_migrations (version) VALUES ('20140521034048');

INSERT INTO schema_migrations (version) VALUES ('20140707170307');

INSERT INTO schema_migrations (version) VALUES ('20140709065408');

INSERT INTO schema_migrations (version) VALUES ('20140709070954');

INSERT INTO schema_migrations (version) VALUES ('20140714130750');

INSERT INTO schema_migrations (version) VALUES ('20140723075454');

INSERT INTO schema_migrations (version) VALUES ('20141205071645');

INSERT INTO schema_migrations (version) VALUES ('20150114182815');

INSERT INTO schema_migrations (version) VALUES ('20150116055154');

INSERT INTO schema_migrations (version) VALUES ('20150123094537');

INSERT INTO schema_migrations (version) VALUES ('20150123102227');

INSERT INTO schema_migrations (version) VALUES ('20150206091020');

INSERT INTO schema_migrations (version) VALUES ('20150206091811');

INSERT INTO schema_migrations (version) VALUES ('20150508064243');

INSERT INTO schema_migrations (version) VALUES ('20150511145632');

INSERT INTO schema_migrations (version) VALUES ('20150511153120');

INSERT INTO schema_migrations (version) VALUES ('20150724090642');

INSERT INTO schema_migrations (version) VALUES ('20150927083915');

INSERT INTO schema_migrations (version) VALUES ('20150927085619');

INSERT INTO schema_migrations (version) VALUES ('20151102171048');

INSERT INTO schema_migrations (version) VALUES ('20151104163627');

INSERT INTO schema_migrations (version) VALUES ('20151105164334');

INSERT INTO schema_migrations (version) VALUES ('20151109161837');

INSERT INTO schema_migrations (version) VALUES ('20151113053628');

INSERT INTO schema_migrations (version) VALUES ('20160201162915');

INSERT INTO schema_migrations (version) VALUES ('20160201174450');

Return-Path: <SRS0=kwZw=BJ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61348C433DF
	for <linux-sparse@archiver.kernel.org>; Thu, 30 Jul 2020 13:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B96C20829
	for <linux-sparse@archiver.kernel.org>; Thu, 30 Jul 2020 13:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgG3NVv (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 30 Jul 2020 09:21:51 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:42664 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgG3NVu (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Jul 2020 09:21:50 -0400
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 29E8D209BD;
        Thu, 30 Jul 2020 13:21:45 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v1] sindex: allow indexing outside the project tree
Date:   Thu, 30 Jul 2020 15:20:33 +0200
Message-Id: <20200730132033.613554-1-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Thu, 30 Jul 2020 13:21:46 +0000 (UTC)
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

One possible way to compile the linux kernel is by using the O=<DIR>
parameter to place all generated files outside the source tree.

Prior to this patch, sindex filters processed sources to exclude system
files. The base directory of the project was the current directory.

When compiled outside of the source tree, this may not be the case.
This patch adds a parameter and an environment variable to specify
the source tree.

You can use it like this:

$ make O=$PWD-build C=2 CHECK="sindex -B $PWD add --"

This parameter is also needed for searching if you want to display
the source code line because sindex does not store lines in the database
but reads them from source files.

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 sindex.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/sindex.c b/sindex.c
index 22836a95..bff6d8c4 100644
--- a/sindex.c
+++ b/sindex.c
@@ -101,11 +101,13 @@ static void show_help(int ret)
 	    "\n"
 	    "Options:\n"
 	    "  -D, --database=FILE    Specify database file (default: %2$s);\n"
+	    "  -B, --basedir=DIR      Define project top directory (default is the current directory);\n"
 	    "  -v, --verbose          Show information about what is being done;\n"
 	    "  -h, --help             Show this text and exit.\n"
 	    "\n"
 	    "Environment:\n"
 	    "  SINDEX_DATABASE        Database file location.\n"
+	    "  SINDEX_BASEDIR         Project top directory.\n"
 	    "\n"
 	    "Report bugs to authors.\n"
 	    "\n",
@@ -125,9 +127,6 @@ static void show_help_add(int ret)
 	    "  -v, --verbose          Show information about what is being done;\n"
 	    "  -h, --help             Show this text and exit.\n"
 	    "\n"
-	    "Environment:\n"
-	    "  SINDEX_BASEDIRE        Project top directory.\n"
-	    "\n"
 	    "Report bugs to authors.\n"
 	    "\n",
 	    progname);
@@ -251,21 +250,26 @@ static void parse_cmdline(int argc, char **argv)
 {
 	static const struct option long_options[] = {
 		{ "database", required_argument, NULL, 'D' },
+		{ "basedir", required_argument, NULL, 'B' },
 		{ "verbose", no_argument, NULL, 'v' },
 		{ "help", no_argument, NULL, 'h' },
 		{ NULL }
 	};
 	int c;
+	char *basedir = getenv("SINDEX_BASEDIR");
 	char *env;
 
 	if ((env = getenv("SINDEX_DATABASE")) != NULL)
 		sindex_dbfile = env;
 
-	while ((c = getopt_long(argc, argv, "+D:vh", long_options, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "+B:D:vh", long_options, NULL)) != -1) {
 		switch (c) {
 			case 'D':
 				sindex_dbfile = optarg;
 				break;
+			case 'B':
+				basedir = optarg;
+				break;
 			case 'v':
 				sindex_verbose++;
 				break;
@@ -278,6 +282,12 @@ static void parse_cmdline(int argc, char **argv)
 		message("command required");
 		show_usage();
 	}
+
+	if (basedir) {
+		if (!realpath(basedir, cwd))
+			sindex_error(1, errno, "unable to get project base directory");
+		n_cwd = strlen(cwd);
+	}
 }
 
 static void parse_cmdline_add(int argc, char **argv)
@@ -1016,6 +1026,9 @@ static void command_search(int argc, char **argv)
 	char *dberr = NULL;
 	sqlite3_str *query = sqlite3_str_new(sindex_db);
 
+	if (chdir(cwd) < 0)
+		sindex_error(1, errno, "unable to change directory: %s", cwd);
+
 	if (query_appendf(query,
 	                  "SELECT"
 	                  " file.name,"
-- 
2.25.4


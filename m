From: Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: [PATCH] sindex: Add option to search by location
Date: Wed, 18 Mar 2020 19:39:24 +0100
Message-ID: <20200318183924.343365-1-gladkov.alexey@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from monster.unsafe.ru ([5.9.28.80]:41152 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgCRSrI (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Mar 2020 14:47:08 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

To create plugin for text editor, it may be useful to be able to search
by position in a file.

$ sindex search -l include/uapi/linux/msdos_fs.h:91:8
(---) fs/fat/dir.c 759 1 fat_ioctl_filldir FAT_IOCTL_FILLDIR_FUNC(fat_ioctl_filldir, __fat_dirent)
(r--) fs/fat/dir.c 759 1 fat_ioctl_filldir FAT_IOCTL_FILLDIR_FUNC(fat_ioctl_filldir, __fat_dirent)
(m--) fs/fat/dir.c 759 1 fat_ioctl_filldir FAT_IOCTL_FILLDIR_FUNC(fat_ioctl_filldir, __fat_dirent)
(def) include/uapi/linux/msdos_fs.h 91 8   long  d_ino;

$ sindex search -l -m w include/uapi/linux/msdos_fs.h:91:8
(m--) fs/fat/dir.c 759 1 fat_ioctl_filldir FAT_IOCTL_FILLDIR_FUNC(fat_ioctl_filldir, __fat_dirent)

Another use is to get the full name of symbol in case of a high level
of nesting:

$ sindex search -e fs/dcache.c:567
(--r) fs/dcache.c 567 9 __dentry_kill   dentry->d_op->d_prune(dentry);
(--r) fs/dcache.c 567 15 __dentry_kill   dentry->d_op->d_prune(dentry);

$ sindex search -e --format='%n' fs/dcache.c:567
dentry.d_op
dentry_operations.d_prune

$ sindex search -e --format='%n' fs/dcache.c:567:9
dentry.d_op

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 sindex.1 |  8 ++++++
 sindex.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/sindex.1 b/sindex.1
index ef39f0f9..e3e14ca3 100644
--- a/sindex.1
+++ b/sindex.1
@@ -17,6 +17,8 @@ sindex \- Semantic Indexer for C
 .B sindex
 [\fIoptions\fR] \fIsearch\fR [\fIcommand options\fR] [\fIpattern\fR]
 .br
+.B sindex [\fIoptions\fR] \fIsearch\fR [\fIcommand options\fR] (\fI-e\fR|\fI-l\fR) \fIfilename\fR:\fIlinenr\fR:\fIcolumn\fR
+.br
 .SH DESCRIPTION
 .P
 sindex is the simple to use cscope-like tool based on sparse/dissect.  Unlike
@@ -75,6 +77,12 @@ specify a kind of symbol (see
 .BR KIND
 below).
 .TP
+\fB-e\fR, \fB--explain\fR
+Show what happens in the specified file position;
+.TP
+\fB-l\fR, \fB--location\fR
+Show usage of symbols from a specific file position;
+.TP
 \fB-v\fR, \fB--verbose\fR
 show information about what is being done;
 .TP
diff --git a/sindex.c b/sindex.c
index c950254b..ea092a4a 100644
--- a/sindex.c
+++ b/sindex.c
@@ -53,6 +53,13 @@ static char *sindex_search_path = NULL;
 static char *sindex_search_symbol = NULL;
 static const char *sindex_search_format = "(%m) %f\t%l\t%c\t%C\t%s";
 
+#define EXPLAIN_LOCATION 1
+#define USAGE_BY_LOCATION 2
+static int sindex_search_by_location;
+static char *sindex_search_filename;
+static int sindex_search_line;
+static int sindex_search_column;
+
 static sqlite3 *sindex_db = NULL;
 static sqlite3_stmt *lock_stmt = NULL;
 static sqlite3_stmt *unlock_stmt = NULL;
@@ -150,6 +157,7 @@ static void show_help_search(int ret)
 {
 	printf(
 	    "Usage: %1$s search [options] [pattern]\n"
+	    "   or: %1$s search [options] (-e|-l) filename[:linenr[:column]]\n"
 	    "\n"
 	    "Utility searches information about symbol by pattern.\n"
 	    "The pattern is a glob(7) wildcard pattern.\n"
@@ -159,6 +167,8 @@ static void show_help_search(int ret)
 	    "  -p, --path=PATTERN     Search symbols only in specified directories;\n"
 	    "  -m, --mode=MODE        Search only the specified type of access;\n"
 	    "  -k, --kind=KIND        Specify a kind of symbol;\n"
+	    "  -e, --explain          Show what happens in the specified file position;\n"
+	    "  -l, --location         Show usage of symbols from a specific file position;\n"
 	    "  -v, --verbose          Show information about what is being done;\n"
 	    "  -h, --help             Show this text and exit.\n"
 	    "\n"
@@ -339,8 +349,10 @@ static void parse_cmdline_rm(int argc, char **argv)
 static void parse_cmdline_search(int argc, char **argv)
 {
 	static const struct option long_options[] = {
+		{ "explain", no_argument, NULL, 'e' },
 		{ "format", required_argument, NULL, 'f' },
 		{ "path", required_argument, NULL, 'p' },
+		{ "location", no_argument, NULL, 'l' },
 		{ "mode", required_argument, NULL, 'm' },
 		{ "kind", required_argument, NULL, 'k' },
 		{ "verbose", no_argument, NULL, 'v' },
@@ -349,8 +361,14 @@ static void parse_cmdline_search(int argc, char **argv)
 	};
 	int c;
 
-	while ((c = getopt_long(argc, argv, "+f:m:k:p:vh", long_options, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "+ef:m:k:p:lvh", long_options, NULL)) != -1) {
 		switch (c) {
+			case 'e':
+				sindex_search_by_location = EXPLAIN_LOCATION;
+				break;
+			case 'l':
+				sindex_search_by_location = USAGE_BY_LOCATION;
+				break;
 			case 'f':
 				sindex_search_format = optarg;
 				break;
@@ -371,7 +389,32 @@ static void parse_cmdline_search(int argc, char **argv)
 		}
 	}
 
-	if (optind < argc)
+	if (sindex_search_by_location) {
+		char *str;
+
+		if (optind == argc)
+			sindex_error(1, 0, "one argument required");
+
+		str = argv[optind];
+
+		while (str) {
+			char *ptr;
+
+			if ((ptr = strchr(str, ':')) != NULL)
+				*ptr++ = '\0';
+
+			if (*str != '\0') {
+				if (!sindex_search_filename) {
+					sindex_search_filename = str;
+				} else if (!sindex_search_line) {
+					sindex_search_line = atoi(str);
+				} else if (!sindex_search_column) {
+					sindex_search_column = atoi(str);
+				}
+			}
+			str = ptr;
+		}
+	} else if (optind < argc)
 		sindex_search_symbol = argv[optind++];
 }
 
@@ -1016,6 +1059,33 @@ static void command_search(int argc, char **argv)
 			goto fail;
 	}
 
+	if (sindex_search_by_location == EXPLAIN_LOCATION) {
+		if (query_appendf(query, " AND file.name == %Q", sindex_search_filename) < 0)
+			goto fail;
+		if (sindex_search_line &&
+		    query_appendf(query, " AND sindex.line == %d", sindex_search_line) < 0)
+			goto fail;
+		if (sindex_search_column &&
+		    query_appendf(query, " AND sindex.column == %d", sindex_search_column) < 0)
+			goto fail;
+	} else if (sindex_search_by_location == USAGE_BY_LOCATION) {
+		if (query_appendf(query, " AND sindex.symbol IN (") < 0)
+			goto fail;
+		if (query_appendf(query,
+		                 "SELECT sindex.symbol FROM sindex, file WHERE"
+				 " sindex.file == file.id AND"
+		                 " file.name == %Q", sindex_search_filename) < 0)
+			goto fail;
+		if (sindex_search_line &&
+		    query_appendf(query, " AND sindex.line == %d", sindex_search_line) < 0)
+			goto fail;
+		if (sindex_search_column &&
+		    query_appendf(query, " AND sindex.column == %d", sindex_search_column) < 0)
+			goto fail;
+		if (query_appendf(query, ")") < 0)
+			goto fail;
+	}
+
 	if (query_appendf(query, " ORDER BY file.name, sindex.line, sindex.column ASC", sindex_search_path) < 0)
 		goto fail;
 
-- 
2.25.1

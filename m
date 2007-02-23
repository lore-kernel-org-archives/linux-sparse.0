From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1] Adding debug option for showing the linearized instruction.
Date: Fri, 23 Feb 2007 14:42:08 -0800
Message-ID: <20070223224208.GB5671@chrisli.org>
References: <20070210001332.GA20604@chrisli.org> <45DE6D69.1050705@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:56278 "EHLO
	rwcrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933257AbXBWXOE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Feb 2007 18:14:04 -0500
Content-Disposition: inline
In-Reply-To: <45DE6D69.1050705@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

On Thu, Feb 22, 2007 at 08:28:25PM -0800, Josh Triplett wrote:
> Looks reasonable; debug information does seem like a logical extension of verbosity.
> 
> Could I get a signoff, please?
> 
> - Josh Triplett
> 

Adding debug option for showing the linearized instruction.

Signed-Off-By: Christopher Li <sparse@chrisli.org>

Index: sparse/lib.c
===================================================================
--- sparse.orig/lib.c	2007-02-02 16:57:04.000000000 -0800
+++ sparse/lib.c	2007-02-02 17:06:51.000000000 -0800
@@ -190,6 +190,9 @@ int Waddress_space = 1;
 int Wenum_mismatch = 1;
 int Wdo_while = 1;
 int Wuninitialized = 1;
+
+int dbg_entry;
+
 int preprocess_only;
 char *include;
 
@@ -237,14 +240,6 @@ static char **handle_switch_E(char *arg,
 	return next;
 }
 
-static char **handle_switch_v(char *arg, char **next)
-{
-	do {
-		verbose++;
-	} while (*++arg == 'v');
-	return next;
-}
-
 static char **handle_switch_I(char *arg, char **next)
 {
 	char *path = arg+1;
@@ -352,14 +347,14 @@ enum {
 };
 
 
-static char **handle_switch_W(char *arg, char **next)
+static char **handle_onoff_switch(char *arg, char **next, const struct warning warnings[], int n)
 {
 	int flag = WARNING_ON;
 	char *p = arg + 1;
 	unsigned i;
 
 	if (!strcmp(p, "all")) {
-		for (i = 0; i < sizeof(warnings) / sizeof(warnings[0]); i++) {
+		for (i = 0; i < n; i++) {
 			if (*warnings[i].flag != WARNING_FORCE_OFF)
 				*warnings[i].flag = WARNING_ON;
 		}
@@ -373,7 +368,7 @@ static char **handle_switch_W(char *arg,
 		flag = WARNING_FORCE_OFF;
 	}
 
-	for (i = 0; i < sizeof(warnings) / sizeof(warnings[0]); i++) {
+	for (i = 0; i < n; i++) {
 		if (!strcmp(p,warnings[i].name)) {
 			*warnings[i].flag = flag;
 			return next;
@@ -381,26 +376,65 @@ static char **handle_switch_W(char *arg,
 	}
 
 	// Unknown.
+	return NULL;
+}
+
+static char **handle_switch_W(char *arg, char **next)
+{
+	char ** ret = handle_onoff_switch(arg, next, warnings, sizeof warnings/sizeof warnings[0]);
+	if (ret)
+		return ret;
+
+	// Unknown.
 	return next;
 }
 
-static void handle_switch_W_finalize(void)
+static struct warning debugs[] = {
+	{ "entry", &dbg_entry},
+};
+
+
+static char **handle_switch_v(char *arg, char **next)
+{
+	char ** ret = handle_onoff_switch(arg, next, debugs, sizeof debugs/sizeof debugs[0]);
+	if (ret)
+		return ret;
+
+	// Unknown.
+	do {
+		verbose++;
+	} while (*++arg == 'v');
+	return next;
+}
+
+
+static void handle_onoff_switch_finalize(const struct warning warnings[], int n)
 {
 	unsigned i;
 
-	for (i = 0; i < sizeof(warnings) / sizeof(warnings[0]); i++) {
+	for (i = 0; i < n; i++) {
 		if (*warnings[i].flag == WARNING_FORCE_OFF)
 			*warnings[i].flag = WARNING_OFF;
 	}
 }
 
+static void handle_switch_W_finalize(void)
+{
+	handle_onoff_switch_finalize(warnings, sizeof(warnings) / sizeof(warnings[0]));
+}
+
+static void handle_switch_v_finalize(void)
+{
+	handle_onoff_switch_finalize(debugs, sizeof(debugs) / sizeof(debugs[0]));
+}
+
 static char **handle_switch_U(char *arg, char **next)
 {
 	const char *name = arg + 1;
 	add_pre_buffer ("#undef %s\n", name);
 	return next;
 }
-
+ 
 static char **handle_switch_O(char *arg, char **next)
 {
 	int level = 1;
@@ -661,6 +695,7 @@ struct symbol_list *sparse_initialize(in
 		add_ptr_list_notag(filelist, arg);
 	}
 	handle_switch_W_finalize();
+	handle_switch_v_finalize();
 
 	list = NULL;
 	if (!ptr_list_empty(filelist)) {
Index: sparse/lib.h
===================================================================
--- sparse.orig/lib.h	2007-02-02 16:57:04.000000000 -0800
+++ sparse/lib.h	2007-02-02 17:06:51.000000000 -0800
@@ -97,6 +97,8 @@ extern int Wcast_truncate;
 extern int Wdo_while;
 extern int Wuninitialized;
 
+extern int dbg_entry;
+
 extern void declare_builtin_functions(void);
 extern void create_builtin_stream(void);
 extern struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list **files);
Index: sparse/sparse.c
===================================================================
--- sparse.orig/sparse.c	2007-02-02 16:57:04.000000000 -0800
+++ sparse/sparse.c	2007-02-02 17:06:51.000000000 -0800
@@ -264,8 +264,12 @@ static void check_symbols(struct symbol_
 
 		expand_symbol(sym);
 		ep = linearize_symbol(sym);
-		if (ep)
+		if (ep) {
+			if (dbg_entry)
+				show_entry(ep);
+
 			check_context(ep);
+		}
 	} END_FOR_EACH_PTR(sym);
 }
 

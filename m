Return-Path: <SRS0=17k7=BP=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC4FC433DF
	for <linux-sparse@archiver.kernel.org>; Wed,  5 Aug 2020 19:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9B9020842
	for <linux-sparse@archiver.kernel.org>; Wed,  5 Aug 2020 19:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgHETyA (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:54:00 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:55066 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbgHEQtE (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 5 Aug 2020 12:49:04 -0400
Received: from comp-core-i7-2640m-0182e6 (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 30BAC20A05;
        Wed,  5 Aug 2020 15:44:51 +0000 (UTC)
Date:   Wed, 5 Aug 2020 17:44:49 +0200
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: Re: sparse | upgrade to upstream v0.6.2 (!2)
Message-ID: <20200805154449.jya7d45vfoi4eea6@comp-core-i7-2640m-0182e6>
References: <note_185431@salsa.debian.org>
 <note_185453@salsa.debian.org>
 <note_185458@salsa.debian.org>
 <note_185460@salsa.debian.org>
 <note_185461@salsa.debian.org>
 <note_185530@salsa.debian.org>
 <note_185532@salsa.debian.org>
 <20200805110418.iutr56vyewhbqr7v@ltop.local>
 <20200805112141.ier2xkhm5sqjtbck@comp-core-i7-2640m-0182e6>
 <20200805152026.djv66eopgsgrtqyk@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200805152026.djv66eopgsgrtqyk@ltop.local>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Wed, 05 Aug 2020 15:44:51 +0000 (UTC)
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Aug 05, 2020 at 05:20:26PM +0200, Luc Van Oostenryck wrote:
> On Wed, Aug 05, 2020 at 01:21:41PM +0200, Alexey Gladkov wrote:
> > On Wed, Aug 05, 2020 at 01:04:18PM +0200, Luc Van Oostenryck wrote:
> > > On Wed, Aug 05, 2020 at 10:37:21AM +0000, Uwe Kleine-König wrote:
> > > > 
> > > > `dissect` seems to be fine, there is only `/lib/systemd/systemd-dissect` in Debian.
> > > > 
> > > > Alternatives that come to my mind are: `sein` (which is German for "be") or `semind` (which sounds a bit like "the mind").
> > > > If there were a mode to emit a tag file (as `ctags` and `etags` do) to be used in an editor, also `stags` is funny.
> > 
> > It looks like a feature request :)
> > 
> > > > 
> > > > All of them seem to be free to be used.
> > 
> > I like 'semind'.
> 
> Excellent.
> Can I apply the attached patch with your signoff and you as author?

Sure.

> -- Luc

> From af1f245feffd2a3a299fad6489dad76066604002 Mon Sep 17 00:00:00 2001
> From: Alexey Gladkov <gladkov.alexey@gmail.com>
> Date: Wed, 5 Aug 2020 17:00:21 +0200
> Subject: [PATCH] sindex: rename it to 'semind'
> 
> The name 'sindex' is already used by another package (biosquid).
> 
> So it was decided to rename it to 'semind'.
> 
> ---
>  .gitignore           |   2 +-
>  Makefile             |  14 +-
>  sindex.1 => semind.1 |  18 +--
>  sindex.c => semind.c | 356 +++++++++++++++++++++----------------------
>  4 files changed, 195 insertions(+), 195 deletions(-)
>  rename sindex.1 => semind.1 (91%)
>  rename sindex.c => semind.c (72%)
> 
> diff --git a/.gitignore b/.gitignore
> index 58598364aac5..63c74afdb156 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -19,7 +19,7 @@ graph
>  obfuscate
>  sparse
>  sparse-llvm
> -sindex
> +semind
>  test-dissect
>  test-inspect
>  test-lexing
> diff --git a/Makefile b/Makefile
> index fea2d74ff59a..639d4f518b7a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -157,17 +157,17 @@ ifeq ($(HAVE_SQLITE),yes)
>  SQLITE_VERSION:=$(shell $(PKG_CONFIG) --modversion sqlite3)
>  SQLITE_VNUMBER:=$(shell printf '%d%02d%02d' $(subst ., ,$(SQLITE_VERSION)))
>  ifeq ($(shell expr "$(SQLITE_VNUMBER)" '>=' 32400),1)
> -PROGRAMS += sindex
> -INST_PROGRAMS += sindex
> -INST_MAN1 += sindex.1
> -sindex-ldlibs := $(shell $(PKG_CONFIG) --libs sqlite3)
> -sindex-cflags := $(shell $(PKG_CONFIG) --cflags sqlite3)
> -sindex-cflags += -std=gnu99
> +PROGRAMS += semind
> +INST_PROGRAMS += semind
> +INST_MAN1 += semind.1
> +semind-ldlibs := $(shell $(PKG_CONFIG) --libs sqlite3)
> +semind-cflags := $(shell $(PKG_CONFIG) --cflags sqlite3)
> +semind-cflags += -std=gnu99
>  else
>  $(warning Your SQLite3 version ($(SQLITE_VERSION)) is too old, 3.24.0 or later is required.)
>  endif
>  else
> -$(warning Your system does not have sqlite3, disabling sindex)
> +$(warning Your system does not have sqlite3, disabling semind)
>  endif
>  
>  # Can we use gtk (needed for test-inspect)
> diff --git a/sindex.1 b/semind.1
> similarity index 91%
> rename from sindex.1
> rename to semind.1
> index 06b0bcff3cd0..44e79346644d 100644
> --- a/sindex.1
> +++ b/semind.1
> @@ -1,27 +1,27 @@
>  .\" Sindex manpage by Alexey Gladkov
> -.TH sindex "1"
> +.TH semind "1"
>  .
>  .SH NAME
> -sindex \- Semantic Indexer for C
> +semind \- Semantic Indexer for C
>  .
>  .SH SYNOPSIS
> -.B sindex
> +.B semind
>  [\fIoptions\fR]
>  .br
> -.B sindex
> +.B semind
>  [\fIoptions\fR] \fIadd\fR [\fIcommand options\fR] [\fI--\fR] [\fIcompiler options\fR] [\fIfiles...\fR]
>  .br
> -.B sindex
> +.B semind
>  [\fIoptions\fR] \fIrm\fR [\fIcommand options\fR] \fIpattern\fR
>  .br
> -.B sindex
> +.B semind
>  [\fIoptions\fR] \fIsearch\fR [\fIcommand options\fR] [\fIpattern\fR]
>  .br
> -.B sindex [\fIoptions\fR] \fIsearch\fR [\fIcommand options\fR] (\fI-e\fR|\fI-l\fR) \fIfilename\fR:\fIlinenr\fR:\fIcolumn\fR
> +.B semind [\fIoptions\fR] \fIsearch\fR [\fIcommand options\fR] (\fI-e\fR|\fI-l\fR) \fIfilename\fR:\fIlinenr\fR:\fIcolumn\fR
>  .br
>  .SH DESCRIPTION
>  .P
> -sindex is the simple to use cscope-like tool based on sparse/dissect.  Unlike
> +semind is the simple to use cscope-like tool based on sparse/dissect.  Unlike
>  cscope it runs after pre-processor and thus it can't index the code filtered out
>  by ifdef's, but otoh it understands how the symbol is used and it can track the
>  usage of struct members.
> @@ -44,7 +44,7 @@ wildcard pattern.
>  .SH COMMON OPTIONS
>  .TP
>  \fB-D\fR, \fB--database=FILE\fR
> -specify database file (default: ./sindex.sqlite).
> +specify database file (default: ./semind.sqlite).
>  .TP
>  \fB-v\fR, \fB--verbose\fR
>  show information about what is being done.
> diff --git a/sindex.c b/semind.c
> similarity index 72%
> rename from sindex.c
> rename to semind.c
> index bff6d8c4df84..911fc7470a30 100644
> --- a/sindex.c
> +++ b/semind.c
> @@ -1,5 +1,5 @@
>  /*
> - * sindex - semantic indexer for C.
> + * semind - semantic indexer for C.
>   *
>   * Copyright (C) 2020  Alexey Gladkov
>   */
> @@ -23,44 +23,44 @@
>  #define U_DEF (0x100 << U_SHIFT)
>  #define SINDEX_DATABASE_VERSION 1
>  
> -#define message(fmt, ...) sindex_error(0, 0, (fmt), ##__VA_ARGS__)
> +#define message(fmt, ...) semind_error(0, 0, (fmt), ##__VA_ARGS__)
>  
>  static const char *progname;
> -static const char *sindex_command = NULL;
> +static const char *semind_command = NULL;
>  
>  // common options
> -static const char *sindex_dbfile = "sindex.sqlite";
> -static int sindex_verbose = 0;
> +static const char *semind_dbfile = "semind.sqlite";
> +static int semind_verbose = 0;
>  static char cwd[PATH_MAX];
>  static size_t n_cwd;
>  
>  // 'add' command options
> -static struct string_list *sindex_filelist = NULL;
> -static int sindex_include_local_syms = 0;
> +static struct string_list *semind_filelist = NULL;
> +static int semind_include_local_syms = 0;
>  
> -struct sindex_streams {
> +struct semind_streams {
>  	sqlite3_int64 id;
>  };
>  
> -static struct sindex_streams *sindex_streams = NULL;
> -static int sindex_streams_nr = 0;
> +static struct semind_streams *semind_streams = NULL;
> +static int semind_streams_nr = 0;
>  
>  // 'search' command options
> -static int sindex_search_modmask;
> -static int sindex_search_modmask_defined = 0;
> -static int sindex_search_kind = 0;
> -static char *sindex_search_path = NULL;
> -static char *sindex_search_symbol = NULL;
> -static const char *sindex_search_format = "(%m) %f\t%l\t%c\t%C\t%s";
> +static int semind_search_modmask;
> +static int semind_search_modmask_defined = 0;
> +static int semind_search_kind = 0;
> +static char *semind_search_path = NULL;
> +static char *semind_search_symbol = NULL;
> +static const char *semind_search_format = "(%m) %f\t%l\t%c\t%C\t%s";
>  
>  #define EXPLAIN_LOCATION 1
>  #define USAGE_BY_LOCATION 2
> -static int sindex_search_by_location;
> -static char *sindex_search_filename;
> -static int sindex_search_line;
> -static int sindex_search_column;
> +static int semind_search_by_location;
> +static char *semind_search_filename;
> +static int semind_search_line;
> +static int semind_search_column;
>  
> -static sqlite3 *sindex_db = NULL;
> +static sqlite3 *semind_db = NULL;
>  static sqlite3_stmt *lock_stmt = NULL;
>  static sqlite3_stmt *unlock_stmt = NULL;
>  static sqlite3_stmt *insert_rec_stmt = NULL;
> @@ -77,9 +77,9 @@ struct command {
>  
>  static void show_usage(void)
>  {
> -	if (sindex_command)
> +	if (semind_command)
>  		printf("Try '%s %s --help' for more information.\n",
> -		       progname, sindex_command);
> +		       progname, semind_command);
>  	else
>  		printf("Try '%s --help' for more information.\n",
>  		       progname);
> @@ -111,7 +111,7 @@ static void show_help(int ret)
>  	    "\n"
>  	    "Report bugs to authors.\n"
>  	    "\n",
> -	    progname, sindex_dbfile);
> +	    progname, semind_dbfile);
>  	exit(ret);
>  }
>  
> @@ -179,17 +179,17 @@ static void show_help_search(int ret)
>  	exit(ret);
>  }
>  
> -static void sindex_print_progname(void)
> +static void semind_print_progname(void)
>  {
>  	fprintf(stderr, "%s: ", progname);
> -	if (sindex_command)
> -		fprintf(stderr, "%s: ", sindex_command);
> +	if (semind_command)
> +		fprintf(stderr, "%s: ", semind_command);
>  }
>  
> -static void sindex_error(int status, int errnum, const char *fmt, ...)
> +static void semind_error(int status, int errnum, const char *fmt, ...)
>  {
>  	va_list ap;
> -	sindex_print_progname();
> +	semind_print_progname();
>  
>  	va_start(ap, fmt);
>  	vfprintf(stderr, fmt, ap);
> @@ -209,10 +209,10 @@ static void set_search_modmask(const char *v)
>  	size_t n = strlen(v);
>  
>  	if (n != 1 && n != 3)
> -		sindex_error(1, 0, "the length of mode value must be 1 or 3: %s", v);
> +		semind_error(1, 0, "the length of mode value must be 1 or 3: %s", v);
>  
> -	sindex_search_modmask_defined = 1;
> -	sindex_search_modmask = 0;
> +	semind_search_modmask_defined = 1;
> +	semind_search_modmask = 0;
>  
>  	if (n == 1) {
>  		switch (v[0]) {
> @@ -220,10 +220,10 @@ static void set_search_modmask(const char *v)
>  			case 'w': v = "ww-"; break;
>  			case 'm': v = "mmm"; break;
>  			case '-': v = "---"; break;
> -			default: sindex_error(1, 0, "unknown modificator: %s", v);
> +			default: semind_error(1, 0, "unknown modificator: %s", v);
>  		}
>  	} else if (!strcmp(v, "def")) {
> -		sindex_search_modmask = U_DEF;
> +		semind_search_modmask = U_DEF;
>  		return;
>  	}
>  
> @@ -235,11 +235,11 @@ static void set_search_modmask(const char *v)
>  
>  	for (int i = 0; i < 3; i++) {
>  		switch (v[i]) {
> -			case 'r': sindex_search_modmask |= modes[i * 3];     break;
> -			case 'w': sindex_search_modmask |= modes[i * 3 + 1]; break;
> -			case 'm': sindex_search_modmask |= modes[i * 3 + 2]; break;
> +			case 'r': semind_search_modmask |= modes[i * 3];     break;
> +			case 'w': semind_search_modmask |= modes[i * 3 + 1]; break;
> +			case 'm': semind_search_modmask |= modes[i * 3 + 2]; break;
>  			case '-': break;
> -			default:  sindex_error(1, 0,
> +			default:  semind_error(1, 0,
>  			                "unknown modificator in the mode value"
>  			                " (`r', `w', `m' or `-' expected): %c", v[i]);
>  		}
> @@ -260,18 +260,18 @@ static void parse_cmdline(int argc, char **argv)
>  	char *env;
>  
>  	if ((env = getenv("SINDEX_DATABASE")) != NULL)
> -		sindex_dbfile = env;
> +		semind_dbfile = env;
>  
>  	while ((c = getopt_long(argc, argv, "+B:D:vh", long_options, NULL)) != -1) {
>  		switch (c) {
>  			case 'D':
> -				sindex_dbfile = optarg;
> +				semind_dbfile = optarg;
>  				break;
>  			case 'B':
>  				basedir = optarg;
>  				break;
>  			case 'v':
> -				sindex_verbose++;
> +				semind_verbose++;
>  				break;
>  			case 'h':
>  				show_help(0);
> @@ -285,7 +285,7 @@ static void parse_cmdline(int argc, char **argv)
>  
>  	if (basedir) {
>  		if (!realpath(basedir, cwd))
> -			sindex_error(1, errno, "unable to get project base directory");
> +			semind_error(1, errno, "unable to get project base directory");
>  		n_cwd = strlen(cwd);
>  	}
>  }
> @@ -305,10 +305,10 @@ static void parse_cmdline_add(int argc, char **argv)
>  	while ((c = getopt_long(argc, argv, "+vh", long_options, NULL)) != -1) {
>  		switch (c) {
>  			case 1:
> -				sindex_include_local_syms = 1;
> +				semind_include_local_syms = 1;
>  				break;
>  			case 'v':
> -				sindex_verbose++;
> +				semind_verbose++;
>  				break;
>  			case 'h':
>  				show_help_add(0);
> @@ -328,7 +328,7 @@ done:
>  	// step back since sparse_initialize will ignore argv[0].
>  	optind--;
>  
> -	sparse_initialize(argc - optind, argv + optind, &sindex_filelist);
> +	sparse_initialize(argc - optind, argv + optind, &semind_filelist);
>  }
>  
>  static void parse_cmdline_rm(int argc, char **argv)
> @@ -343,7 +343,7 @@ static void parse_cmdline_rm(int argc, char **argv)
>  	while ((c = getopt_long(argc, argv, "+vh", long_options, NULL)) != -1) {
>  		switch (c) {
>  			case 'v':
> -				sindex_verbose++;
> +				semind_verbose++;
>  				break;
>  			case 'h':
>  				show_help_rm(0);
> @@ -374,36 +374,36 @@ static void parse_cmdline_search(int argc, char **argv)
>  	while ((c = getopt_long(argc, argv, "+ef:m:k:p:lvh", long_options, NULL)) != -1) {
>  		switch (c) {
>  			case 'e':
> -				sindex_search_by_location = EXPLAIN_LOCATION;
> +				semind_search_by_location = EXPLAIN_LOCATION;
>  				break;
>  			case 'l':
> -				sindex_search_by_location = USAGE_BY_LOCATION;
> +				semind_search_by_location = USAGE_BY_LOCATION;
>  				break;
>  			case 'f':
> -				sindex_search_format = optarg;
> +				semind_search_format = optarg;
>  				break;
>  			case 'm':
>  				set_search_modmask(optarg);
>  				break;
>  			case 'k':
> -				sindex_search_kind = tolower(optarg[0]);
> +				semind_search_kind = tolower(optarg[0]);
>  				break;
>  			case 'p':
> -				sindex_search_path = optarg;
> +				semind_search_path = optarg;
>  				break;
>  			case 'v':
> -				sindex_verbose++;
> +				semind_verbose++;
>  				break;
>  			case 'h':
>  				show_help_search(0);
>  		}
>  	}
>  
> -	if (sindex_search_by_location) {
> +	if (semind_search_by_location) {
>  		char *str;
>  
>  		if (optind == argc)
> -			sindex_error(1, 0, "one argument required");
> +			semind_error(1, 0, "one argument required");
>  
>  		str = argv[optind];
>  
> @@ -414,18 +414,18 @@ static void parse_cmdline_search(int argc, char **argv)
>  				*ptr++ = '\0';
>  
>  			if (*str != '\0') {
> -				if (!sindex_search_filename) {
> -					sindex_search_filename = str;
> -				} else if (!sindex_search_line) {
> -					sindex_search_line = atoi(str);
> -				} else if (!sindex_search_column) {
> -					sindex_search_column = atoi(str);
> +				if (!semind_search_filename) {
> +					semind_search_filename = str;
> +				} else if (!semind_search_line) {
> +					semind_search_line = atoi(str);
> +				} else if (!semind_search_column) {
> +					semind_search_column = atoi(str);
>  				}
>  			}
>  			str = ptr;
>  		}
>  	} else if (optind < argc)
> -		sindex_search_symbol = argv[optind++];
> +		semind_search_symbol = argv[optind++];
>  }
>  
>  static int query_appendf(sqlite3_str *query, const char *fmt, ...)
> @@ -452,22 +452,22 @@ static int query_appendf(sqlite3_str *query, const char *fmt, ...)
>  static inline void sqlite_bind_text(sqlite3_stmt *stmt, const char *field, const char *var, int len)
>  {
>  	if (sqlite3_bind_text(stmt, sqlite3_bind_parameter_index(stmt, field), var, len, SQLITE_STATIC) != SQLITE_OK)
> -		sindex_error(1, 0, "unable to bind value for %s: %s", field, sqlite3_errmsg(sindex_db));
> +		semind_error(1, 0, "unable to bind value for %s: %s", field, sqlite3_errmsg(semind_db));
>  }
>  
>  static inline void sqlite_bind_int64(sqlite3_stmt *stmt, const char *field, long long var)
>  {
>  	if (sqlite3_bind_int64(stmt, sqlite3_bind_parameter_index(stmt, field), var) != SQLITE_OK)
> -		sindex_error(1, 0, "unable to bind value for %s: %s", field, sqlite3_errmsg(sindex_db));
> +		semind_error(1, 0, "unable to bind value for %s: %s", field, sqlite3_errmsg(semind_db));
>  }
>  
>  static inline void sqlite_prepare(const char *sql, sqlite3_stmt **stmt)
>  {
>  	int ret;
>  	do {
> -		ret = sqlite3_prepare_v2(sindex_db, sql, -1, stmt, NULL);
> +		ret = sqlite3_prepare_v2(semind_db, sql, -1, stmt, NULL);
>  		if (ret != SQLITE_OK && ret != SQLITE_BUSY)
> -			sindex_error(1, 0, "unable to prepare query: %s: %s", sqlite3_errmsg(sindex_db), sql);
> +			semind_error(1, 0, "unable to prepare query: %s: %s", sqlite3_errmsg(semind_db), sql);
>  	} while (ret == SQLITE_BUSY);
>  }
>  
> @@ -475,9 +475,9 @@ static inline void sqlite_prepare_persistent(const char *sql, sqlite3_stmt **stm
>  {
>  	int ret;
>  	do {
> -		ret = sqlite3_prepare_v3(sindex_db, sql, -1, SQLITE_PREPARE_PERSISTENT, stmt, NULL);
> +		ret = sqlite3_prepare_v3(semind_db, sql, -1, SQLITE_PREPARE_PERSISTENT, stmt, NULL);
>  		if (ret != SQLITE_OK && ret != SQLITE_BUSY)
> -			sindex_error(1, 0, "unable to prepare query: %s: %s", sqlite3_errmsg(sindex_db), sql);
> +			semind_error(1, 0, "unable to prepare query: %s: %s", sqlite3_errmsg(semind_db), sql);
>  	} while (ret == SQLITE_BUSY);
>  }
>  
> @@ -494,7 +494,7 @@ static int sqlite_run(sqlite3_stmt *stmt)
>  {
>  	int ret = sqlite3_step(stmt);
>  	if (ret != SQLITE_DONE && ret != SQLITE_ROW)
> -		sindex_error(1, 0, "unable to process query: %s: %s", sqlite3_errmsg(sindex_db), sqlite3_sql(stmt));
> +		semind_error(1, 0, "unable to process query: %s: %s", sqlite3_errmsg(semind_db), sqlite3_sql(stmt));
>  	return ret;
>  }
>  
> @@ -522,7 +522,7 @@ static sqlite3_int64 get_db_version(void)
>  static void set_db_version(void)
>  {
>  	char *sql;
> -	sqlite3_str *query = sqlite3_str_new(sindex_db);
> +	sqlite3_str *query = sqlite3_str_new(semind_db);
>  
>  	if (query_appendf(query, "PRAGMA user_version = %d", SINDEX_DATABASE_VERSION) < 0)
>  		exit(1);
> @@ -536,7 +536,7 @@ static void open_temp_database(void)
>  {
>  	static const char *database_schema[] = {
>  		"ATTACH ':memory:' AS tempdb",
> -		"CREATE TABLE tempdb.sindex ("
> +		"CREATE TABLE tempdb.semind ("
>  			" file INTEGER NOT NULL,"
>  			" line INTEGER NOT NULL,"
>  			" column INTEGER NOT NULL,"
> @@ -560,7 +560,7 @@ static void open_database(const char *filename, int flags)
>  			" name TEXT UNIQUE NOT NULL,"
>  			" mtime INTEGER NOT NULL"
>  		")",
> -		"CREATE TABLE sindex ("
> +		"CREATE TABLE semind ("
>  			" file INTEGER NOT NULL REFERENCES file(id) ON DELETE CASCADE,"
>  			" line INTEGER NOT NULL,"
>  			" column INTEGER NOT NULL,"
> @@ -569,15 +569,15 @@ static void open_database(const char *filename, int flags)
>  			" context TEXT,"
>  			" mode INTEGER NOT NULL"
>  		")",
> -		"CREATE UNIQUE INDEX sindex_0 ON sindex (symbol, kind, mode, file, line, column)",
> -		"CREATE INDEX sindex_1 ON sindex (file)",
> +		"CREATE UNIQUE INDEX semind_0 ON semind (symbol, kind, mode, file, line, column)",
> +		"CREATE INDEX semind_1 ON semind (file)",
>  		NULL,
>  	};
>  
>  	int exists = !access(filename, R_OK);
>  
> -	if (sqlite3_open_v2(filename, &sindex_db, flags, NULL) != SQLITE_OK)
> -		sindex_error(1, 0, "unable to open database: %s: %s", filename, sqlite3_errmsg(sindex_db));
> +	if (sqlite3_open_v2(filename, &semind_db, flags, NULL) != SQLITE_OK)
> +		semind_error(1, 0, "unable to open database: %s: %s", filename, sqlite3_errmsg(semind_db));
>  
>  	sqlite_command("PRAGMA journal_mode = WAL");
>  	sqlite_command("PRAGMA synchronous = OFF");
> @@ -587,7 +587,7 @@ static void open_database(const char *filename, int flags)
>  
>  	if (exists) {
>  		if (get_db_version() < SINDEX_DATABASE_VERSION)
> -			sindex_error(1, 0, "%s: Database too old. Please rebuild it.", filename);
> +			semind_error(1, 0, "%s: Database too old. Please rebuild it.", filename);
>  		return;
>  	}
>  
> @@ -627,16 +627,16 @@ static void insert_record(struct index_record *rec)
>  
>  static void update_stream(void)
>  {
> -	if (sindex_streams_nr >= input_stream_nr)
> +	if (semind_streams_nr >= input_stream_nr)
>  		return;
>  
> -	sindex_streams = realloc(sindex_streams, input_stream_nr * sizeof(struct sindex_streams));
> -	if (!sindex_streams)
> -		sindex_error(1, errno, "realloc");
> +	semind_streams = realloc(semind_streams, input_stream_nr * sizeof(struct semind_streams));
> +	if (!semind_streams)
> +		semind_error(1, errno, "realloc");
>  
>  	sqlite_run(lock_stmt);
>  
> -	for (int i = sindex_streams_nr; i < input_stream_nr; i++) {
> +	for (int i = semind_streams_nr; i < input_stream_nr; i++) {
>  		struct stat st;
>  		const char *filename;
>  		char fullname[PATH_MAX];
> @@ -647,26 +647,26 @@ static void update_stream(void)
>  			 * FIXME: Files in the input_streams may be duplicated.
>  			 */
>  			if (stat(input_streams[i].name, &st) < 0)
> -				sindex_error(1, errno, "stat: %s", input_streams[i].name);
> +				semind_error(1, errno, "stat: %s", input_streams[i].name);
>  
>  			cur_mtime = st.st_mtime;
>  
>  			if (!realpath(input_streams[i].name, fullname))
> -				sindex_error(1, errno, "realpath: %s", input_streams[i].name);
> +				semind_error(1, errno, "realpath: %s", input_streams[i].name);
>  
>  			if (!strncmp(fullname, cwd, n_cwd) && fullname[n_cwd] == '/') {
>  				filename = fullname + n_cwd + 1;
> -				sindex_streams[i].id = 0;
> +				semind_streams[i].id = 0;
>  			} else {
> -				sindex_streams[i].id = -1;
> +				semind_streams[i].id = -1;
>  				continue;
>  			}
>  		} else {
> -			sindex_streams[i].id = -1;
> +			semind_streams[i].id = -1;
>  			continue;
>  		}
>  
> -		if (sindex_verbose > 1)
> +		if (semind_verbose > 1)
>  			message("filename: %s", filename);
>  
>  		sqlite_bind_text(select_file_stmt, "@name", filename, -1);
> @@ -674,7 +674,7 @@ static void update_stream(void)
>  		if (sqlite_run(select_file_stmt) == SQLITE_ROW) {
>  			sqlite3_int64 old_mtime;
>  
> -			sindex_streams[i].id = sqlite3_column_int64(select_file_stmt, 0);
> +			semind_streams[i].id = sqlite3_column_int64(select_file_stmt, 0);
>  			old_mtime = sqlite3_column_int64(select_file_stmt, 1);
>  
>  			sqlite_reset_stmt(select_file_stmt);
> @@ -694,12 +694,12 @@ static void update_stream(void)
>  		sqlite_run(insert_file_stmt);
>  		sqlite_reset_stmt(insert_file_stmt);
>  
> -		sindex_streams[i].id = sqlite3_last_insert_rowid(sindex_db);
> +		semind_streams[i].id = sqlite3_last_insert_rowid(semind_db);
>  	}
>  
>  	sqlite_run(unlock_stmt);
>  
> -	sindex_streams_nr = input_stream_nr;
> +	semind_streams_nr = input_stream_nr;
>  }
>  
>  static void r_symbol(unsigned mode, struct position *pos, struct symbol *sym)
> @@ -710,10 +710,10 @@ static void r_symbol(unsigned mode, struct position *pos, struct symbol *sym)
>  
>  	update_stream();
>  
> -	if (sindex_streams[pos->stream].id == -1)
> +	if (semind_streams[pos->stream].id == -1)
>  		return;
>  
> -	if (!sindex_include_local_syms && sym_is_local(sym))
> +	if (!semind_include_local_syms && sym_is_local(sym))
>  		return;
>  
>  	if (!sym->ident) {
> @@ -730,7 +730,7 @@ static void r_symbol(unsigned mode, struct position *pos, struct symbol *sym)
>  	rec.sym_len = sym->ident->len;
>  	rec.kind    = sym->kind;
>  	rec.mode    = mode;
> -	rec.file    = sindex_streams[pos->stream].id;
> +	rec.file    = semind_streams[pos->stream].id;
>  	rec.line    = pos->line;
>  	rec.col     = pos->pos;
>  
> @@ -747,10 +747,10 @@ static void r_member(unsigned mode, struct position *pos, struct symbol *sym, st
>  
>  	update_stream();
>  
> -	if (sindex_streams[pos->stream].id == -1)
> +	if (semind_streams[pos->stream].id == -1)
>  		return;
>  
> -	if (!sindex_include_local_syms && sym_is_local(sym))
> +	if (!semind_include_local_syms && sym_is_local(sym))
>  		return;
>  
>  	ni = built_in_ident("?");
> @@ -769,7 +769,7 @@ static void r_member(unsigned mode, struct position *pos, struct symbol *sym, st
>  	rec.sym_len = si->len + mi->len + 1;
>  	rec.kind    = 'm';
>  	rec.mode    = mode;
> -	rec.file    = sindex_streams[pos->stream].id;
> +	rec.file    = semind_streams[pos->stream].id;
>  	rec.line    = pos->line;
>  	rec.col     = pos->pos;
>  
> @@ -806,7 +806,7 @@ static void command_add(int argc, char **argv)
>  		&unlock_stmt);
>  
>  	sqlite_prepare_persistent(
> -		"INSERT OR IGNORE INTO tempdb.sindex "
> +		"INSERT OR IGNORE INTO tempdb.semind "
>  		"(context, symbol, kind, mode, file, line, column) "
>  		"VALUES (@context, @symbol, @kind, @mode, @file, @line, @column)",
>  		&insert_rec_stmt);
> @@ -823,10 +823,10 @@ static void command_add(int argc, char **argv)
>  		"DELETE FROM file WHERE name == @name",
>  		&delete_file_stmt);
>  
> -	dissect(&reporter, sindex_filelist);
> +	dissect(&reporter, semind_filelist);
>  
>  	sqlite_run(lock_stmt);
> -	sqlite_command("INSERT OR IGNORE INTO sindex SELECT * FROM tempdb.sindex");
> +	sqlite_command("INSERT OR IGNORE INTO semind SELECT * FROM tempdb.semind");
>  	sqlite_run(unlock_stmt);
>  
>  	sqlite3_finalize(insert_rec_stmt);
> @@ -835,7 +835,7 @@ static void command_add(int argc, char **argv)
>  	sqlite3_finalize(delete_file_stmt);
>  	sqlite3_finalize(lock_stmt);
>  	sqlite3_finalize(unlock_stmt);
> -	free(sindex_streams);
> +	free(semind_streams);
>  }
>  
>  static void command_rm(int argc, char **argv)
> @@ -845,7 +845,7 @@ static void command_rm(int argc, char **argv)
>  	sqlite_command("BEGIN IMMEDIATE");
>  	sqlite_prepare("DELETE FROM file WHERE name GLOB @file", &stmt);
>  
> -	if (sindex_verbose > 1)
> +	if (semind_verbose > 1)
>  		message("SQL: %s", sqlite3_sql(stmt));
>  
>  	for (int i = 0; i < argc; i++) {
> @@ -877,12 +877,12 @@ static inline void print_mode(char *value)
>  #undef U
>  }
>  
> -static char *sindex_file_name;
> -static FILE *sindex_file_fd;
> -static int sindex_file_lnum;
> -static char *sindex_line;
> -static size_t sindex_line_buflen;
> -static int sindex_line_len;
> +static char *semind_file_name;
> +static FILE *semind_file_fd;
> +static int semind_file_lnum;
> +static char *semind_line;
> +static size_t semind_line_buflen;
> +static int semind_line_len;
>  
>  static void print_file_line(const char *name, int lnum)
>  {
> @@ -890,43 +890,43 @@ static void print_file_line(const char *name, int lnum)
>  	 * All files are sorted by name and line number. So, we can reopen
>  	 * the file and read it line by line.
>  	 */
> -	if (!sindex_file_name || strcmp(sindex_file_name, name)) {
> -		if (sindex_file_fd) {
> -			fclose(sindex_file_fd);
> -			free(sindex_file_name);
> +	if (!semind_file_name || strcmp(semind_file_name, name)) {
> +		if (semind_file_fd) {
> +			fclose(semind_file_fd);
> +			free(semind_file_name);
>  		}
>  
> -		sindex_file_name = strdup(name);
> +		semind_file_name = strdup(name);
>  
> -		if (!sindex_file_name)
> -			sindex_error(1, errno, "strdup");
> +		if (!semind_file_name)
> +			semind_error(1, errno, "strdup");
>  
> -		sindex_file_fd = fopen(name, "r");
> +		semind_file_fd = fopen(name, "r");
>  
> -		if (!sindex_file_fd)
> -			sindex_error(1, errno, "fopen: %s", name);
> +		if (!semind_file_fd)
> +			semind_error(1, errno, "fopen: %s", name);
>  
> -		sindex_file_lnum = 0;
> +		semind_file_lnum = 0;
>  	}
>  
>  	do {
> -		if (sindex_file_lnum == lnum) {
> -			if (sindex_line[sindex_line_len-1] == '\n')
> -				sindex_line_len--;
> -			printf("%.*s", sindex_line_len, sindex_line);
> +		if (semind_file_lnum == lnum) {
> +			if (semind_line[semind_line_len-1] == '\n')
> +				semind_line_len--;
> +			printf("%.*s", semind_line_len, semind_line);
>  			break;
>  		}
> -		sindex_file_lnum++;
> +		semind_file_lnum++;
>  		errno = 0;
> -	} while((sindex_line_len = getline(&sindex_line, &sindex_line_buflen, sindex_file_fd)) != -1);
> +	} while((semind_line_len = getline(&semind_line, &semind_line_buflen, semind_file_fd)) != -1);
>  
>  	if (errno && errno != EOF)
> -		sindex_error(1, errno, "getline");
> +		semind_error(1, errno, "getline");
>  }
>  
>  static int search_query_callback(void *data, int argc, char **argv, char **colname)
>  {
> -	char *fmt = (char *) sindex_search_format;
> +	char *fmt = (char *) semind_search_format;
>  	char buf[32];
>  	int quote = 0;
>  	int n = 0;
> @@ -948,7 +948,7 @@ static int search_query_callback(void *data, int argc, char **argv, char **colna
>  			c = *fmt;
>  
>  			if (c == '\0')
> -				sindex_error(1, 0, "unexpected end of format string");
> +				semind_error(1, 0, "unexpected end of format string");
>  
>  			switch (c) {
>  				case 'f': colnum = 0; goto print_string;
> @@ -995,7 +995,7 @@ static int search_query_callback(void *data, int argc, char **argv, char **colna
>  			}
>  
>  			if (pos == fmt)
> -				sindex_error(1, 0, "invalid format specification: %%%c", c);
> +				semind_error(1, 0, "invalid format specification: %%%c", c);
>  
>  			continue;
>  		} else if (c == '\\') {
> @@ -1024,104 +1024,104 @@ static void command_search(int argc, char **argv)
>  {
>  	char *sql;
>  	char *dberr = NULL;
> -	sqlite3_str *query = sqlite3_str_new(sindex_db);
> +	sqlite3_str *query = sqlite3_str_new(semind_db);
>  
>  	if (chdir(cwd) < 0)
> -		sindex_error(1, errno, "unable to change directory: %s", cwd);
> +		semind_error(1, errno, "unable to change directory: %s", cwd);
>  
>  	if (query_appendf(query,
>  	                  "SELECT"
>  	                  " file.name,"
> -	                  " sindex.line,"
> -	                  " sindex.column,"
> -	                  " sindex.context,"
> -	                  " sindex.symbol,"
> -	                  " sindex.mode,"
> -	                  " sindex.kind "
> -	                  "FROM sindex, file "
> -	                  "WHERE sindex.file == file.id") < 0)
> +	                  " semind.line,"
> +	                  " semind.column,"
> +	                  " semind.context,"
> +	                  " semind.symbol,"
> +	                  " semind.mode,"
> +	                  " semind.kind "
> +	                  "FROM semind, file "
> +	                  "WHERE semind.file == file.id") < 0)
>  		goto fail;
>  
> -	if (sindex_search_kind) {
> -		if (query_appendf(query, " AND sindex.kind == %d", sindex_search_kind) < 0)
> +	if (semind_search_kind) {
> +		if (query_appendf(query, " AND semind.kind == %d", semind_search_kind) < 0)
>  			goto fail;
>  	}
>  
> -	if (sindex_search_symbol) {
> +	if (semind_search_symbol) {
>  		int ret;
>  
>  		if (query_appendf(query, " AND ") < 0)
>  			goto fail;
>  
> -		if (strpbrk(sindex_search_symbol, "*?[]"))
> -			ret = query_appendf(query, "sindex.symbol GLOB %Q", sindex_search_symbol);
> +		if (strpbrk(semind_search_symbol, "*?[]"))
> +			ret = query_appendf(query, "semind.symbol GLOB %Q", semind_search_symbol);
>  		else
> -			ret = query_appendf(query, "sindex.symbol == %Q", sindex_search_symbol);
> +			ret = query_appendf(query, "semind.symbol == %Q", semind_search_symbol);
>  
>  		if (ret < 0)
>  			goto fail;
>  	}
>  
> -	if (sindex_search_modmask_defined) {
> -		if (!sindex_search_modmask) {
> -			if (query_appendf(query, " AND sindex.mode == %d", sindex_search_modmask) < 0)
> +	if (semind_search_modmask_defined) {
> +		if (!semind_search_modmask) {
> +			if (query_appendf(query, " AND semind.mode == %d", semind_search_modmask) < 0)
>  				goto fail;
> -		} else if (query_appendf(query, " AND (sindex.mode & %d) != 0", sindex_search_modmask) < 0)
> +		} else if (query_appendf(query, " AND (semind.mode & %d) != 0", semind_search_modmask) < 0)
>  			goto fail;
>  	}
>  
> -	if (sindex_search_path) {
> -		if (query_appendf(query, " AND file.name GLOB %Q", sindex_search_path) < 0)
> +	if (semind_search_path) {
> +		if (query_appendf(query, " AND file.name GLOB %Q", semind_search_path) < 0)
>  			goto fail;
>  	}
>  
> -	if (sindex_search_by_location == EXPLAIN_LOCATION) {
> -		if (query_appendf(query, " AND file.name == %Q", sindex_search_filename) < 0)
> +	if (semind_search_by_location == EXPLAIN_LOCATION) {
> +		if (query_appendf(query, " AND file.name == %Q", semind_search_filename) < 0)
>  			goto fail;
> -		if (sindex_search_line &&
> -		    query_appendf(query, " AND sindex.line == %d", sindex_search_line) < 0)
> +		if (semind_search_line &&
> +		    query_appendf(query, " AND semind.line == %d", semind_search_line) < 0)
>  			goto fail;
> -		if (sindex_search_column &&
> -		    query_appendf(query, " AND sindex.column == %d", sindex_search_column) < 0)
> +		if (semind_search_column &&
> +		    query_appendf(query, " AND semind.column == %d", semind_search_column) < 0)
>  			goto fail;
> -	} else if (sindex_search_by_location == USAGE_BY_LOCATION) {
> -		if (query_appendf(query, " AND sindex.symbol IN (") < 0)
> +	} else if (semind_search_by_location == USAGE_BY_LOCATION) {
> +		if (query_appendf(query, " AND semind.symbol IN (") < 0)
>  			goto fail;
>  		if (query_appendf(query,
> -		                 "SELECT sindex.symbol FROM sindex, file WHERE"
> -				 " sindex.file == file.id AND"
> -		                 " file.name == %Q", sindex_search_filename) < 0)
> +		                 "SELECT semind.symbol FROM semind, file WHERE"
> +				 " semind.file == file.id AND"
> +		                 " file.name == %Q", semind_search_filename) < 0)
>  			goto fail;
> -		if (sindex_search_line &&
> -		    query_appendf(query, " AND sindex.line == %d", sindex_search_line) < 0)
> +		if (semind_search_line &&
> +		    query_appendf(query, " AND semind.line == %d", semind_search_line) < 0)
>  			goto fail;
> -		if (sindex_search_column &&
> -		    query_appendf(query, " AND sindex.column == %d", sindex_search_column) < 0)
> +		if (semind_search_column &&
> +		    query_appendf(query, " AND semind.column == %d", semind_search_column) < 0)
>  			goto fail;
>  		if (query_appendf(query, ")") < 0)
>  			goto fail;
>  	}
>  
> -	if (query_appendf(query, " ORDER BY file.name, sindex.line, sindex.column ASC", sindex_search_path) < 0)
> +	if (query_appendf(query, " ORDER BY file.name, semind.line, semind.column ASC", semind_search_path) < 0)
>  		goto fail;
>  
>  	sql = sqlite3_str_value(query);
>  
> -	if (sindex_verbose > 1)
> +	if (semind_verbose > 1)
>  		message("SQL: %s", sql);
>  
> -	sqlite3_exec(sindex_db, sql, search_query_callback, NULL, &dberr);
> +	sqlite3_exec(semind_db, sql, search_query_callback, NULL, &dberr);
>  	if (dberr)
> -		sindex_error(1, 0, "sql query failed: %s", dberr);
> +		semind_error(1, 0, "sql query failed: %s", dberr);
>  fail:
>  	sql = sqlite3_str_finish(query);
>  	sqlite3_free(sql);
>  
> -	if (sindex_file_fd) {
> -		fclose(sindex_file_fd);
> -		free(sindex_file_name);
> +	if (semind_file_fd) {
> +		fclose(semind_file_fd);
> +		free(semind_file_name);
>  	}
> -	free(sindex_line);
> +	free(semind_line);
>  }
>  
>  
> @@ -1156,25 +1156,25 @@ int main(int argc, char **argv)
>  		progname++;
>  
>  	if (!realpath(".", cwd))
> -		sindex_error(1, errno, "unable to get current directory");
> +		semind_error(1, errno, "unable to get current directory");
>  	n_cwd = strlen(cwd);
>  
>  	parse_cmdline(argc, argv);
>  
>  	for (cmd = commands; cmd->name && strcmp(argv[optind], cmd->name); cmd++);
>  	if (!cmd->name)
> -		sindex_error(1, 0, "unknown command: %s", argv[optind]);
> +		semind_error(1, 0, "unknown command: %s", argv[optind]);
>  	optind++;
>  
> -	sindex_command = cmd->name;
> +	semind_command = cmd->name;
>  
>  	if (cmd->parse_cmdline)
>  		cmd->parse_cmdline(argc, argv);
>  
> -	open_database(sindex_dbfile, cmd->dbflags);
> +	open_database(semind_dbfile, cmd->dbflags);
>  	cmd->handler(argc - optind, argv + optind);
>  
> -	sqlite3_close(sindex_db);
> +	sqlite3_close(semind_db);
>  
>  	return 0;
>  }
> -- 
> 2.28.0
> 


-- 
Rgrds, legion


Return-Path: <SRS0=kwZw=BJ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE29C433E0
	for <linux-sparse@archiver.kernel.org>; Thu, 30 Jul 2020 21:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C07E02070B
	for <linux-sparse@archiver.kernel.org>; Thu, 30 Jul 2020 21:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgG3VFY (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 30 Jul 2020 17:05:24 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:42858 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbgG3VFY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Jul 2020 17:05:24 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k1Fju-001peC-EA; Thu, 30 Jul 2020 15:05:22 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k1Fjt-0002B6-Gz; Thu, 30 Jul 2020 15:05:22 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     linux-sparse@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
References: <20200730132033.613554-1-gladkov.alexey@gmail.com>
Date:   Thu, 30 Jul 2020 16:02:12 -0500
In-Reply-To: <20200730132033.613554-1-gladkov.alexey@gmail.com> (Alexey
        Gladkov's message of "Thu, 30 Jul 2020 15:20:33 +0200")
Message-ID: <87d04c67jf.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k1Fjt-0002B6-Gz;;;mid=<87d04c67jf.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/fmdB5dXTEvCFJN4DsdaH9gR6PHr962w8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v1] sindex: allow indexing outside the project tree
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> One possible way to compile the linux kernel is by using the O=<DIR>
> parameter to place all generated files outside the source tree.
>
> Prior to this patch, sindex filters processed sources to exclude system
> files. The base directory of the project was the current directory.
>
> When compiled outside of the source tree, this may not be the case.
> This patch adds a parameter and an environment variable to specify
> the source tree.
>
> You can use it like this:
>
> $ make O=$PWD-build C=2 CHECK="sindex -B $PWD add --"
>
> This parameter is also needed for searching if you want to display
> the source code line because sindex does not store lines in the database
> but reads them from source files.

Tested-by: "Eric W. Biederman" <ebiederm@xmission.com>

This simple little example search now works for me:

sindex --database=$PWD-build/sindex.sqlite search -m w task_struct.pid 

> Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> ---
>  sindex.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/sindex.c b/sindex.c
> index 22836a95..bff6d8c4 100644
> --- a/sindex.c
> +++ b/sindex.c
> @@ -101,11 +101,13 @@ static void show_help(int ret)
>  	    "\n"
>  	    "Options:\n"
>  	    "  -D, --database=FILE    Specify database file (default: %2$s);\n"
> +	    "  -B, --basedir=DIR      Define project top directory (default is the current directory);\n"
>  	    "  -v, --verbose          Show information about what is being done;\n"
>  	    "  -h, --help             Show this text and exit.\n"
>  	    "\n"
>  	    "Environment:\n"
>  	    "  SINDEX_DATABASE        Database file location.\n"
> +	    "  SINDEX_BASEDIR         Project top directory.\n"
>  	    "\n"
>  	    "Report bugs to authors.\n"
>  	    "\n",
> @@ -125,9 +127,6 @@ static void show_help_add(int ret)
>  	    "  -v, --verbose          Show information about what is being done;\n"
>  	    "  -h, --help             Show this text and exit.\n"
>  	    "\n"
> -	    "Environment:\n"
> -	    "  SINDEX_BASEDIRE        Project top directory.\n"
> -	    "\n"
>  	    "Report bugs to authors.\n"
>  	    "\n",
>  	    progname);
> @@ -251,21 +250,26 @@ static void parse_cmdline(int argc, char **argv)
>  {
>  	static const struct option long_options[] = {
>  		{ "database", required_argument, NULL, 'D' },
> +		{ "basedir", required_argument, NULL, 'B' },
>  		{ "verbose", no_argument, NULL, 'v' },
>  		{ "help", no_argument, NULL, 'h' },
>  		{ NULL }
>  	};
>  	int c;
> +	char *basedir = getenv("SINDEX_BASEDIR");
>  	char *env;
>  
>  	if ((env = getenv("SINDEX_DATABASE")) != NULL)
>  		sindex_dbfile = env;
>  
> -	while ((c = getopt_long(argc, argv, "+D:vh", long_options, NULL)) != -1) {
> +	while ((c = getopt_long(argc, argv, "+B:D:vh", long_options, NULL)) != -1) {
>  		switch (c) {
>  			case 'D':
>  				sindex_dbfile = optarg;
>  				break;
> +			case 'B':
> +				basedir = optarg;
> +				break;
>  			case 'v':
>  				sindex_verbose++;
>  				break;
> @@ -278,6 +282,12 @@ static void parse_cmdline(int argc, char **argv)
>  		message("command required");
>  		show_usage();
>  	}
> +
> +	if (basedir) {
> +		if (!realpath(basedir, cwd))
> +			sindex_error(1, errno, "unable to get project base directory");
> +		n_cwd = strlen(cwd);
> +	}
>  }
>  
>  static void parse_cmdline_add(int argc, char **argv)
> @@ -1016,6 +1026,9 @@ static void command_search(int argc, char **argv)
>  	char *dberr = NULL;
>  	sqlite3_str *query = sqlite3_str_new(sindex_db);
>  
> +	if (chdir(cwd) < 0)
> +		sindex_error(1, errno, "unable to change directory: %s", cwd);
> +
>  	if (query_appendf(query,
>  	                  "SELECT"
>  	                  " file.name,"

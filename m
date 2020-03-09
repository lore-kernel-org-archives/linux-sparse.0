From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] Add symantic index utility
Date: Mon, 9 Mar 2020 23:37:01 +0100
Message-ID: <20200309223701.dbnej7esb4qp56bm@ltop.local>
References: <20200309152509.6707-1-gladkov.alexey@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37197 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgCIWhF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 9 Mar 2020 18:37:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id a141so339131wme.2
        for <linux-sparse@vger.kernel.org>; Mon, 09 Mar 2020 15:37:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200309152509.6707-1-gladkov.alexey@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Gladkov <gladkov.alexey@gmail.com>
Cc: linux-sparse@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>

On Mon, Mar 09, 2020 at 04:25:09PM +0100, Alexey Gladkov wrote:
> sindex is the simple to use cscope-like tool based on sparse/dissect.
> Unlike cscope it runs after pre-processor and thus it can't index the
> code filtered out by ifdef's, but otoh it understands how the symbol
> is used and it can track the usage of struct members.

Hi,

This looks pretty good.
I just have a few non-essential remarks I've added here below.

> To create an index for your linux kernel configuration:
> 
> $ make C=2 CHECK="sindex add --"
> 
> Now, to find where a definition of the pid field from the task_struct
> structure:
> 
> $ sindex search -m def task_struct.pid
> (def) include/linux/sched.h 793 11   pid_t    pid;
> 
> default output format:
> 
> SOURCE-FILE \t LINE-NUMBER \t COLUMN \t IN FUNCTION NAME \t CODE LINE
> 
> To find where this field changes:
> 
> $ sindex search -m w task_struct.pid
> (-w-) fs/exec.c 1154 6 de_thread   tsk->pid = leader->pid;
> (-w-) kernel/fork.c 2155 3 copy_process  p->pid = pid_nr(pid);
> 
> To get only filenames and line number you can change output format:
> 
> $ sindex search -f '%f:%l' -m w task_struct.pid
> fs/exec.c:1154
> kernel/fork.c:2155

It would be great to add this and the equivalent of the show_usage()
function into a manpage (I don't mind to do the formatting, just the
content is fine).

It would also be great if some doc could be added to explain the
meaning of the kinds (s, f, v, m) and the 'access fields' (def),
'(-r-)', ... but yes, that's really something for dissect itself.
 
> diff --git a/sindex.c b/sindex.c
> new file mode 100644
> index 00000000..8478fe33
> --- /dev/null
> +++ b/sindex.c
> @@ -0,0 +1,1109 @@
> +/*
> + * sindex - semantic indexer for C.
> + *
> + * Copyright (C) 2020  Alexey Gladkov
> + */
> +
> +#define _GNU_SOURCE
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +
> +#include <unistd.h>
> +#include <limits.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <fcntl.h>
> +#include <getopt.h>
> +#include <ctype.h>
> +#include <errno.h>
> +#include <error.h>

<error.h> is glibc specific. This makes the build fail on
non-glibc platforms. This dependencies should be removed
or some tests should be added to the Makefile to not build
this program if glibs is not present.

> +
> +static void
> +show_usage(void)

I would prefer: static void show_usage(...
but I don't mind much.

> +	    "These are common %1$s commands used in various situations:\n"
> +	    "  add      Generate or updates symantic index file for c-source code;\n"

I think you mean "semantic index" (same for the title of the patch).

> +static void
> +set_search_modmask(const char *v)
> +{
> +	size_t n = strlen(v);
> +
> +	if (n != 1 && n != 3)
> +		error(1, 0, "the length of mode value must be 1 or 3: %s", v);
> +
> +	sindex_search_modmask_defined = 1;
> +	sindex_search_modmask = 0;
> +
> +	if (n == 1) {
> +		switch (v[0]) {
> +			case 'r': v = "rrr"; break;
> +			case 'w': v = "ww-"; break;
> +			case 'm': v = "mmm"; break;
> +			case '-': v = "---"; break;
> +			default: error(1, 0, "unknown modificator: %s", v);
> +		}
> +	} else if (!strcmp(v, "def")) {
> +		sindex_search_modmask = U_DEF;
> +		return;
> +	}
> +
> +	int modes[] = {
> +		U_R_AOF, U_W_AOF, U_R_AOF | U_W_AOF,
> +		U_R_VAL, U_W_VAL, U_R_VAL | U_W_VAL,
> +		U_R_PTR, U_W_PTR, U_R_PTR | U_W_PTR,
> +	};

Please, move this table at the top of the function, wth static const.

> +static void
> +set_db_version(void)
> +{
> +	sqlite3_str *query = sqlite3_str_new(sindex_db);
> +
> +	if (query_appendf(query, "PRAGMA user_version = %d", SINDEX_DATABASE_VERSION) < 0)
> +		exit(1);
> +
> +	char *sql = sqlite3_str_finish(query);
> +	sqlite_command(sql);
> +	sqlite3_free(sql);
> +}
> +
> +static void
> +open_temp_database(void)
> +{
> +	const char *database_schema[] = {

+static
+const ?

> +static void
> +open_database(const char *filename, int flags)
> +{
> +	int exists = !access(filename, R_OK);
> +
> +	if (sqlite3_open_v2(filename, &sindex_db, flags, NULL) != SQLITE_OK)
> +		error(1, 0, "unable to open database: %s: %s", filename, sqlite3_errmsg(sindex_db));
> +
> +	sqlite_command("PRAGMA journal_mode = WAL");
> +	sqlite_command("PRAGMA synchronous = OFF");
> +	sqlite_command("PRAGMA secure_delete = FAST");
> +	sqlite_command("PRAGMA busy_timeout = 2147483647");
> +	sqlite_command("PRAGMA foreign_keys = ON");
> +
> +	if (exists) {
> +		if (get_db_version() < SINDEX_DATABASE_VERSION)
> +			error(1, 0, "%s: Database too old. Please rebuild it.", filename);
> +		return;
> +	}
> +
> +	set_db_version();
> +
> +	const char *database_schema[] = {

idem.

> +static void
> +r_member(unsigned mode, struct position *pos, struct symbol *sym, struct symbol *mem)
> +{
> +	struct ident *ni, *si, *mi;
> +	static struct ident null;
> +	struct ident *ctx = &null;
> +	struct index_record rec;
> +
> +	update_stream();
> +
> +	if (sindex_streams[pos->stream].id == -1)
> +		return;
> +
> +	if (!sindex_include_local_syms && sym_is_local(sym))
> +		return;
> +
> +	ni = built_in_ident("?");
> +	si = sym->ident ?: ni;
> +	/* mem == NULL means entire struct accessed */
> +	mi = mem ? (mem->ident ?: ni) : built_in_ident("*");
> +
> +	if (dissect_ctx)
> +		ctx = dissect_ctx->ident;
> +
> +	static char memname[1024];

please, move the declaration on top.

> +static void
> +command_search(int argc, char **argv)
> +{

...

> +	if (sindex_search_symbol) {
> +		if (query_appendf(query, " AND ") < 0)
> +			goto fail;
> +
> +		int ret;
> +

same here.

> +int
> +main(int argc, char **argv)
> +{
> +	struct command commands[] = {

static?


Best regards,
-- Luc

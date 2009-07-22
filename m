From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 5/5] Add a --version option to sparse
Date: Tue, 21 Jul 2009 17:57:33 -0700
Message-ID: <70318cbf0907211757w1e0e3436hcc8b679c6de60804@mail.gmail.com>
References: <4A62395D.9000207@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f173.google.com ([209.85.221.173]:65130 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbZGVA5d (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 21 Jul 2009 20:57:33 -0400
Received: by qyk3 with SMTP id 3so1433313qyk.33
        for <linux-sparse@vger.kernel.org>; Tue, 21 Jul 2009 17:57:33 -0700 (PDT)
In-Reply-To: <4A62395D.9000207@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, Jul 18, 2009 at 2:06 PM, Ramsay Jones<ramsay@ramsay1.demon.co.uk> wrote:
>
> In addition to a minimal --version implementation, using
> the output of 'git describe', we also output the version
> string when -v(erbose) output has been requested.
>
> Also, when cgcc internally sets the $gcc_base_dir, the
> compiler invocation is changed to use an explicit gcc
> command, rather than $cc. (when --version is part of
> $cc, this breaks badly).
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

Sorry I did not have a chance to reply it earlier. I was on a trip, very limited
Internet access.

> ---
>
> Hi Chris,
>
> This patch actually adds a feature :-)
>
> This is a minimal implementation and doesn't address the issue
> of a sparse library version number; should the library define
> some version macros like __SPARSE_MAJOR, __SPARSE_MINOR, etc.?
> Dunno.

I don't mind sparse has a version number. Some thing like 4.2.0 etc.
I would rather not mix that version number with the git commit hash.
The git commit hash has very limited usage. I think just print it as
part of the generic verbose printing is good enough. Add the printing in
handle_switch_v_finalize() so other executable can get it as well.

Thanks

Chris

From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 5/5] Add a --version option to sparse
Date: Fri, 24 Jul 2009 20:30:58 +0100
Message-ID: <4A6A0BF2.7080509@ramsay1.demon.co.uk>
References: <4A62395D.9000207@ramsay1.demon.co.uk> <70318cbf0907211757w1e0e3436hcc8b679c6de60804@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:61385 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754033AbZGXTeV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 24 Jul 2009 15:34:21 -0400
In-Reply-To: <70318cbf0907211757w1e0e3436hcc8b679c6de60804@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

Christopher Li wrote:
> I don't mind sparse has a version number. Some thing like 4.2.0 etc.
> I would rather not mix that version number with the git commit hash.

The commit hash is only part of the version number string when you
build in a git repo and your HEAD does not reference a release
commit (as indicated by a tag object on this commit).

Note that the "dist" make target already uses 'git describe' to check
that the release tag and VERSION makefile variable agree.

$ git checkout master
$ git describe
0.4.1-99-g37f041a
$ git checkout 0.4.1
Note: moving to '0.4.1' which isn't a local branch
If you want to create a new branch from this checkout, you may do so
(now or later) by using -b with the checkout command again. Example:
  git checkout -b <new_branch_name>
HEAD is now at a02aeb3... Makefile: VERSION=0.4.1
$ git describe
0.4.1
$ 

[Note that I don't check for locally modified files and add "-dirty"
to the version string like git does; that is partly what I meant by
"minimal implementation"]

> The git commit hash has very limited usage. I think just print it as
> part of the generic verbose printing is good enough. Add the printing in
> handle_switch_v_finalize() so other executable can get it as well.
> 

Hmm, Oops! Now I remember... ahem *blush*, I had intended to modify
this patch before publishing it. (As I said before, this is quite an
old patch; I had a TODO to fix it up).

However, the fixup I have in mind involves moving most of the handling
of the --version option out of the library and into the sparse executable.
(i.e. more or less the opposite of what you suggest above for -v ;-) ).

My intent with this patch was to provide sparse (the program) with a
version number; *not* the sparse library, which is a separate issue.
(If a library version number is implemented, then the sparse program
version number *could* be the same number, of course). I did not
consider the other example programs built with sparse, but I suppose
they could all share the same version number if necessary.

However, you would not want sparse (the library) to force *all*
applications built with the library to handle the --version option
by printing the sparse (the program) version string and exiting!

So, the library should just set a version_option seen flag and let
the application process this flag itself.

Hmm, I don't have time tonight to re-write the patch, but I will
send a new version soon.

ATB,
Ramsay Jones


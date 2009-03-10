From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [patches] more declarations fixes
Date: Tue, 10 Mar 2009 22:42:14 +0000
Message-ID: <20090310224214.GU28946@ZenIV.linux.org.uk>
References: <E1LgZcm-0000qk-0S@ZenIV.linux.org.uk> <70318cbf0903101427y238844d9xfa19baa8c637437e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:32991 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbZCJWmR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 10 Mar 2009 18:42:17 -0400
Content-Disposition: inline
In-Reply-To: <70318cbf0903101427y238844d9xfa19baa8c637437e@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

On Tue, Mar 10, 2009 at 02:27:26PM -0700, Christopher Li wrote:
> On Mon, Mar 9, 2009 at 12:10 AM, Al Viro <viro@ftp.linux.org.uk> wrote:
> >
> > OK, that pile ought to take care of a lot of nastiness. ?We still have
> > rather messy crap in attributes' handling, but it's actually getting
> > cleaner now. ?In particular, direct_declarator and declaration_specifiers
> > are relatively sane, handling of type specifiers should be correct now (and
> > much cleaner than it used to be) and most of the tangled mess around
> > attributes is untangled. ?Still a mess, but at least doing something
> > about it becomes feasible...
> >
> 
> I really like these series of patches. All applied.
> 
> It is much cleaner now.
> 
> BTW, what does Set_S and Set_T means? Symbol and type?

s/symbol/solitary/, actually (it's used for the things that don't mix with
other specifiers at all).  T is more or less "type" - it's for the large
group of specifiers that are mutually exclusive (int/char/double/float/all
solitary ones - the only things that are *not* part of that set are
signed/unsigned/long/short).  For the sake of completeness, Set_Vlong (used
to track having seen "long" twice) comes from the name Plan 9 C compiler
used (pre-C99) for long long; they call it vlong, presumably with "v" for
"very".

FWIW, float could be considered solitary too, if not for (yet to be supported)
_Complex.  Parser-side modifications to support that would be fairly simple,
especially if we support gcc extensions[1].  Of course, we'd need to deal
with that more than just in parser - expand.c and evaluate.c at the very
least, and we'd need new EXPR_... node types for constant values...


[1] C99 gives parser a bit of a wart since _Complex, _Complex long and
long _Complex are not accepted, so we get valid combinations that have
invalid prefices; not a big deal.  Requires slightly different definition
for complex_op and an extra check and warning in the end of process.
gcc, out of either laziness or sheer insanity allows complex for *any*
arithmetic types, even though e.g. complex char makes no sense whatsoever,
so it's even simpler for parser to deal with.

Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0238C347539
	for <linux-sparse@vger.kernel.org>; Mon, 16 Mar 2026 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644002; cv=none; b=rmTMzk7Cbl3KX6x25XudjSh95kdHYsMzpjfxK9RVl1ekCbg981dv7kuX2MlFr++Cy8yrL15vGC5ucZ85FYWT2MFFPqQa37qGxTOIkUar8HxJ755QM+gutA4C22XYa/mkjtMoWvaMDuGRexVEmfan9apWV1sdgwJdxradZ2+ZZlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644002; c=relaxed/simple;
	bh=p5N9WMoieauRcPRoRGZL0NvFa+PUPDK4zAG7ZVKFlEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haclYU61MBj7zHE2qtvunvf2n1DFh5zTTvVe1KvAKbq/8Il4/TxgOKAZn5McBmsNSd21KDVnF0xbypsDJNnEvF53maxuwiSlEpznqxQr1hXHl9CpLGK8tHOdomKXOmwWU0qm273koWOvYRJmwADoTol71ls/gplMjc1MB0sxBIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Bbxf3QSQ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Bbxf3QSQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=4S1p93NxvIBPYlXviGS1gVh50zXXui8HDEXGNqs3kkA=; b=Bbxf3QSQHW+BljecU7VLMfRmRu
	MZQwgKt9Vm9Z+KMb2p7s2bBXio/GFebNU80xaGYRBO6xfB803+Tln1pltiywkklp5Oc+yqtL5rEmT
	/5snKOnBIEF3o7vSw1YeCum0MRWuJmorWZRDR/174g+DufFQw4KZgVFfnlUCrJV51o19FhFU2LDJA
	GVMp0jSwC6YMZGFqablG5Je+w8TF77F4pUwXN6oVd9z5USfF3ZODe+2c+pLV279HyWaud6M/LiKMp
	G7rnx3fUEGy6Qdt4q4XlqNyfACruAS5mFZnbda/Gaixf7pdDJ/19/rVT1KwNCRV/8bzj4kBVut/Zt
	/DEwES5Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w21sE-00000003B9t-0MsF;
	Mon, 16 Mar 2026 06:56:22 +0000
Date: Mon, 16 Mar 2026 06:56:22 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Eric Zhang <zxh@xh-zhang.com>
Cc: linux-sparse@vger.kernel.org, dan.carpenter@linaro.org,
	chriscli@google.com, ben.dooks@codethink.co.uk,
	rf@opensource.cirrus.com, torvalds@linux-foundation.org
Subject: Re: [RFC PATCH] pre-process: add __VA_OPT__ support
Message-ID: <20260316065622.GA607739@ZenIV>
References: <20260225072731.GA3093958@ZenIV>
 <20260225081413.2480484-1-zxh@xh-zhang.com>
 <20260225221851.GE1762976@ZenIV>
 <20260226072945.GA4104757@ZenIV>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226072945.GA4104757@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Feb 26, 2026 at 07:29:45AM +0000, Al Viro wrote:
> On Wed, Feb 25, 2026 at 10:18:51PM +0000, Al Viro wrote:
> 
> > NOTE: substitute() is the second hottest loop in the entire thing; only
> > tokenizer is hotter.  And gcc is too enthusiastic about the inlining
> > around that function, ending up with bad register spills, along with
> > a bunch of stalls.  Worse, decisions are sensitive to minor changes in
> > places textually far away, making it a real bitch to deal with.
> > Makes for fun reordering the commits in local queue... ;-/
> 
> FWIW, looking at that thing again, I wonder if we would be better off
> with doing argument expansion on demand rather than doing it in
> expand_arguments().  Should be doable with a bit of care - we'd need
> to mark the TOKEN_..._ARG with several bits to decide whether we
> want to duplicate or not, etc., but that's worth doing anyway -
> better than playing with the counters.
> 
> Note, BTW, that collapsing TOKEN_..._ARG together, with "kind of argument"
> moved into bits stolen from ->argnum improves code generation - that
> switch by token type is _hot_ and it reducing the number of cases
> gives a measurable speedup.  Sure, we don't want heavy work at #define
> time - most of the macros are never expanded at all, but AFAICS this
> kind of processing can be dealt with while parsing the body, with no
> extra passes needed, etc.
> 
> I'm going down right now, will look into that tomorrow morning...

That turned out to be trickier than I hoped, but I've got something that
works.

See git://git.kernel.org/pub/scm/linux/kernel/git/viro/sparse.git #va_opt
(or individual patches in followups)

__VA_OPT__ supported, AFAICS behaviour matches C23.
	* expansion and stringifying of arguments is full-lazy now -
done on demand and at most once.
	* va-opt-replacement parsed at #define time, handled correctly
by dump_macro() (i.e. -dM), comparisons when redefining and at expansion
time.
	* arglist mangling is gone, so's the argcount kludge.
	* it's no slower than it used to be prior to that series.

I have local followups (tentative fixes for whitespace handling in preprocessor
and optimizations in tokenizer), but let's deal with that one first.

Shortlog:
Al Viro (21):
      split copy() into "need to copy" and "can move in place" cases
      expand and simplify the call of dup_token() in copy()
      more dup_token() optimizations
      parsing #define: saner handling of argument count, part 1
      simplify collect_arguments() and fix error handling there
      try_arg(): don't use arglist for argument name lookups
      make expand_has_...() responsible for expanding its argument
      preparing to change argument number encoding for TOKEN_..._ARGUMENT
      steal 2 bits from argnum for argument kind
      on-demand argument expansion
      kill create_arglist()
      stop mangling arglist, get rid of TOKEN_ARG_COUNT
      deal with ## on arguments separately
      preparations for __VA_OPT__ support: reshuffle argument slot assignments
      pre-process.c: split try_arg()
      __VA_OPT__: parsing
      expansion-time va_opt handling
      merge(): saner handling of ->noexpand
      simplify the calling conventions of collect_arguments()
      make expand_one_symbol() inline
      substitute(): convert switch() into cascade of ifs

Diffstat:
 ident-list.h                                |   1 +
 pre-process.c                               | 929 +++++++++++++++++-----------
 symbol.h                                    |   1 +
 token.h                                     |  32 +-
 tokenize.c                                  |   4 -
 validation/preprocessor/bad-args.c          |  18 +
 validation/preprocessor/dump-macro.c        |  13 +
 validation/preprocessor/has-attribute.c     |   3 +
 validation/preprocessor/has-builtin.c       |   3 +
 validation/preprocessor/va_opt.c            |  54 ++
 validation/preprocessor/va_opt2.c           |  34 +
 validation/preprocessor/va_opt_compare.c    |  28 +
 validation/preprocessor/va_opt_parse.c      |  37 ++
 validation/preprocessor/va_opt_whitespace.c |  14 +
 14 files changed, 797 insertions(+), 374 deletions(-)
 create mode 100644 validation/preprocessor/bad-args.c
 create mode 100644 validation/preprocessor/dump-macro.c
 create mode 100644 validation/preprocessor/va_opt.c
 create mode 100644 validation/preprocessor/va_opt2.c
 create mode 100644 validation/preprocessor/va_opt_compare.c
 create mode 100644 validation/preprocessor/va_opt_parse.c
 create mode 100644 validation/preprocessor/va_opt_whitespace.c


PS: as for the interesting uses of __VA_OPT__, consider this:
; cat >test.c <<'EOF'
// based on a fun trick from David Mazières
// see https://www.scs.stanford.edu/~dm/blog/va-opt.html for the entire story
// No, it's not unbounded recursion - up to 256 (4^4) elements in __VA_ARGS__;
// more with trivial modifications, just add more levels to EXPAND...
#define PARENS ()
#define EXPAND(...) EXPAND4(EXPAND4(EXPAND4(EXPAND4(__VA_ARGS__))))
#define EXPAND4(...) EXPAND3(EXPAND3(EXPAND3(EXPAND3(__VA_ARGS__))))
#define EXPAND3(...) EXPAND2(EXPAND2(EXPAND2(EXPAND2(__VA_ARGS__))))
#define EXPAND2(...) EXPAND1(EXPAND1(EXPAND1(EXPAND1(__VA_ARGS__))))
#define EXPAND1(...) __VA_ARGS__
#define FOR_EACH_PAIR(macro, ...)				\
  __VA_OPT__(EXPAND(FOR_EACH_PAIR_HELPER(macro, __VA_ARGS__)))
#define FOR_EACH_PAIR_HELPER(macro, a1, a2, ...)		\
  macro(a1, a2)							\
  __VA_OPT__(FOR_EACH_PAIR_AGAIN PARENS (macro, __VA_ARGS__))
#define FOR_EACH_PAIR_AGAIN() FOR_EACH_PAIR_HELPER

FOR_EACH_PAIR(F, t1, id1, t2, id2, t3, id3, t4, id4, t5, id5, t6, id6)
EOF
; cpp -E test.c
# 0 "test.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 0 "<command-line>" 2
# 1 "test.c"
# 18 "test.c"
F(t1, id1) F(t2, id2) F(t3, id3) F(t4, id4) F(t5, id5) F(t6, id6)
;

and the same output from sparse, modulo the # ... lines - sparse -E doesn't
produce those.  Our (fairly brittle) analogue is __MAP in linux/syscalls.h
and if nothing else, unlike __MAP() this thing does not need the number
of pairs passed as explicit argument.  Would be interesting to try unifying
SYSCALL0..SYSCALL6 into a single macro that would bloody well _count_ the
arguments...

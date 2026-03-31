Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5DD3C0630
	for <linux-sparse@vger.kernel.org>; Tue, 31 Mar 2026 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774944185; cv=none; b=rSG7Ie808i4uViVzbVbq1cAmxrIPGNW9uiUp7Yjy4mxeQeuuQDOzGSNgT5gyDfHOAu8Mk3drvv8ktkt2rA19JtctiLq4386Ot8n/ZePQ8xdlO3dIWGRRbmHAXqjsNMvFSLGz/xGUf0EjpNgxfRXDlZpl9N6azC+tL5TTp4qFb4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774944185; c=relaxed/simple;
	bh=Qwn2Qgy1c/1CHOz2Z0arcndzmP4W2wUnoZhebDQ2bxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKLglp2ER+EKM6lbd47kFshcs0+DZIDe2Ys0IOhqr88hu4sL28L2f3nkbLCgcZV106bsJw5o872szKk4A4v7xXj5OpxlHWFrrN3rhcjVjMsPsSZBrGcqD53hKIUZwBSyLMJLi5La8/EyEjTloHN2eo+nDwrg9N9qnOW3/6XQx/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ai9szDPp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ai9szDPp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lZhuqiEKbQG/bQAqFXKDqQ8dqVS1yEK7shfBRAtGeKE=; b=Ai9szDPp+VNN2PFRelSmI2EwqF
	gIKG7QZuUuI0X4139TKHGC8otE7k8SbU4l4OmHdcJjCKJEtapWE8U/KOJtgve5+R/shQfyNmTK01p
	PT45imOuMtZMKIomnz/9Yf6EjJBNmzps5s/A0H4biqBRWt3Eaub66iZGY8zV6wU/i+rRPb/sGBJwk
	r7Rs8wmAodC3d9UczJ+OAqHq6kfTAc6uoUTfcznvJT+T/wBPTfP6VMR841ErpRJN2R9RR195ncDxJ
	EBFzsktWv0hq5TDi3uDtCr71pITLCPA5CUgj7hHEksWCz7wyY3i428TppYh9HAp2wTHfDh5IK9I84
	m1NRUUZg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w7U7L-00000005mXl-0n0R;
	Tue, 31 Mar 2026 08:06:31 +0000
Date: Tue, 31 Mar 2026 09:06:31 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: chriscli@google.com
Cc: linux-sparse@vger.kernel.org, dan.carpenter@linaro.org,
	ben.dooks@codethink.co.uk, rf@opensource.cirrus.com,
	torvalds@linux-foundation.org, Eric Zhang <zxh@xh-zhang.com>
Subject: Re: [RFC PATCH] pre-process: add __VA_OPT__ support
Message-ID: <20260331080631.GA1328137@ZenIV>
References: <20260225072731.GA3093958@ZenIV>
 <20260225081413.2480484-1-zxh@xh-zhang.com>
 <20260225221851.GE1762976@ZenIV>
 <20260226072945.GA4104757@ZenIV>
 <20260316065622.GA607739@ZenIV>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316065622.GA607739@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Mar 16, 2026 at 06:56:22AM +0000, Al Viro wrote:

... and here's are the whitespace fixes and a bunch of optimizations; I
really wonder if we ought to simply switch to uint64_t for struct position
contents and go for several helpers for accessing individual parts.
Code generation with clang is reasonable, but gcc is bloody awful -
I'm sick and tired of fighting it all the time ;-/ Anyway, I've spent
way too much time in that rabbit hole.  I've a few more sitting in the
local queue (tokenizer optimizations, mostly), but that's a separate
story and I'd rather leave that for later.

See git://git.kernel.org/pub/scm/linux/kernel/git/viro/sparse.git #whitespaces
(or individual patches in followups); it's on top of #va_opt.

Re whitespace: there are several places where gcc and clang handling of
that stuff differs.  The origin of the headache is that historically
preprocessor had been a text filter sitting in front of compiler -
its output had been fed through tokenizer and quite a few things in the
original ANSI C bear the resulting scars.  By C99 times it mostly switched
to working in terms of token stream, which simplified a lot of stuff.
Unfortunately, what it's working with is not quite a list of tokens -
it's tokens mixed with whitespace.  By that point comments are replaced
with spaces and implementation is allowed to collapse any sequence of
whitespace other than newline into a single space character.

All operations on the stream are described in terms of replacing a
token or a sequence of tokens with a sequence of tokens; what happens
to possible whitespace is almost unspecified.

Some things are obvious and generally agreed upon:
	* if we are replacing a sequence of tokens, all whitespace stuck
between them is removed.  All whitespace before to the first or after the
last affected token in left as-is.
	* all whitespace stuck between the tokens in the replacement
sequence is inserted along with those tokens.

What is *not* obvious is what should be done to leading or trailing
whitespace in the replacement sequence.  Part of that is explicitly
covered (e.g. macro body has no leading or trailing whitespace), but in
some cases the things get iffy.  Trivial example:

#define E
#define F E - E
#define S(X) #X
#define A(X) S([X])
char *s = A(F);

A(F) is a macro invocation; there's one argument - Ident(F).  No whitespace
anywhere.  What should these 4 tokens be replaced with?  We start with the
replacement list of A - Ident(S),Punctuator('('),Punctuator('['),Ident(X),
Punctuator(']'),Punctuator(')').  The only parameter (X) occurs only once
and there's neither # nor ## operator in sight, so that occurrence gets
replaced with the token sequence resulting from full expansion of the
corresponding argument.

Ident(F) expands to Ident(E),whitespace,Punctuator('-'),whitespace,Ident(E),
which, after expanding both instances of E turns into
	whitespace,Punctuator('-'),whitespace

Fair enough, there's only one token in that, so there's no inter-token
whitespace in sight.  There is both leading and trailing whitespace, though.

One interpretation is that this one token is precisely what gets substituted,
yielding  S([-]) with no whitespace anywhere.  That's an invocation of
S with the sole argument being Punctuator('['),Punctuator('-),Punctuator(']'),
and the end result is "[-]".  This is what clang does.

Another way to handle that is to have the whitespace preceding and following
Punctuator('-') in the expansion of F stuck to it when we are substituting
the damn thing, yielding S([ - ]) (same tokens as in the first variant, but
with whitespaces stuck before and after the minus).  The end result in this
interpretation is "[ - ]".  This is what gcc goes for.

Unfortunately, gcc rules are convoluted and when you add __VA_OPT__ into
the mix they get really nasty.

Example:
#define E
#define F E - E
#define S(X) #X
#define A(X,...) S([__VA_OPT__(X)])
char *s = A(F,_);

ends up with "[- ]" - the leading whitespace is stripped, the trailing one
remains stuck to the token sequence.  Mixing that with ## leads to outright
bugs:

#define E
#define F1 E 1
#define A(X,...) 1##__VA_OPT__(X)
int m1 = A(F1,...);

expands into

int m1 = 11;

In other words, left concatenation works fine.  However, adding the right-hand
analogue

#define F2 sizeof m E
#define B(X,...) __VA_OPT__(X)##1
int m2 = B(F2,_);

which should result in

int m2 = sizeof m1;

does *not* work with gcc - it ends up with

int m2 = sizeof m 1;

with predictable objections from the parser.  Note that it's *not* a matter of
confusion re "do we expand the argument here?" - if that argument hadn't been
expanded, we would've ended up with

int m2 = sizeof F21;

and resulting errors would've been different.  With clang everything works
as expected and I don't see any interpretation of the standard that would
allow what gcc is doing.  The trigger for that bug is their treatment of the
trailing whitespace, AFAICS; leading whitespace is stripped here.

Note that the current mainline sparse doesn't match either gcc or clang
semantics - it loses whitespaces in some cases where they definitely should
be retained.  That needs to be fixed; e.g.
#define E
#define S(X) #X
#define A(X) S(X)
char *s = A([1 E]);
ought to produce "[1 ]", not "[1]".  Nothing subtle about that case...

IMO we are be better off with the clang approach; it is easy to describe
and it matches the behaviour of gcc unless you step into the areas where gcc
is rather random.  We can always reconsider if/when gcc folks come up with
something that looks consistent...

Shortlog:

Al Viro (6):
      nextchar(): get rid of special[]
      simplify the inlined side of nextchar()
      tokenize_stream(): don't bother with isspace()
      TOKEN_DIRECTIVE: recognize directive-introducing # in tokenizer
      saner collect_arg() code generation
      try to get whitespaces right

Diffstat:
 pre-process.c                           | 169 ++++++++++++++++++--------------
 token.h                                 |   1 +
 tokenize.c                              |  91 +++++++++--------
 validation/preprocessor/va_opt-concat.c |  24 +++++
 validation/preprocessor/va_opt.c        |  23 +++--
 validation/preprocessor/va_opt2.c       |   2 +-
 6 files changed, 184 insertions(+), 126 deletions(-)
 create mode 100644 validation/preprocessor/va_opt-concat.c

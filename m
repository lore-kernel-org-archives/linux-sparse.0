From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: fun with declarations and definitions
Date: Mon, 9 Feb 2009 08:54:01 +0000
Message-ID: <20090209085400.GT28946@ZenIV.linux.org.uk>
References: <20090202073018.GB28946@ZenIV.linux.org.uk> <70318cbf0902021907w634ffc6dm693022b23a0eabfc@mail.gmail.com> <20090203041317.GH28946@ZenIV.linux.org.uk> <70318cbf0902051040m7506a365s784a591667358f1f@mail.gmail.com> <498B3435.8010506@knosof.co.uk> <20090205202811.GO28946@ZenIV.linux.org.uk> <20090205211921.GP28946@ZenIV.linux.org.uk> <20090206053655.GS28946@ZenIV.linux.org.uk> <70318cbf0902082352n32450ca2g87c847bb035baf15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:35311 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbZBIIyE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Feb 2009 03:54:04 -0500
Content-Disposition: inline
In-Reply-To: <70318cbf0902082352n32450ca2g87c847bb035baf15@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Derek M Jones <derek@knosof.co.uk>, linux-sparse@vger.kernel.org

On Sun, Feb 08, 2009 at 11:52:23PM -0800, Christopher Li wrote:
> > Subject: [PATCH] Handle nested declarators vs. parameter lists correctly
> >
> > Seeing a typedef name after ( means that we have a parameter-type-list
> > only if we are parsing a parameter declaration or a typename; otherwise
> > it might very well be a redeclaration (e.g. int (T); when T had been a
> > typedef in outer scope).
> 
> The patch looks great. Applied.

Still leaves a couple of uglies, BTW.  One (easily fixed):

int [2]*p[3];

is actually (still) accepted.  Nevermind, we just need to set dont_nest
in a few more places (and no, it's not a regression; moreover, similar
crap works with functions instead of arrays).

Nastier one:
#define A __attribute__((address_space(1)))
void (*f)(A int *x, A int *y) = (void *)0;
void g(int A *x)
{
        f(x, x);
}

now try test-parsing on it.  You'll see that f gets type
void (A *)(int *, int A *);
instead of expected
void (*)(int A *, int A *);

Reason: cretinous gcc grammar is fscked in head.  There's a very, _very_
good reason why C doesn't allow e.g.
	int (const x);
Consider seeing
	void f(int (const
What would that "(const" be?  Beginning of parameter list in the first
parameter of f or a beginning of nested declarator in the same?  In
C it's the former and we can tell that immediately.

I really don't want to get into the reasons why gcc decided to allow that with
s/const/__attribute__((....))/ - it's too long a flame, but they did and
so we have to do lookahead from hell in parser.  Namely, eat all attributes
first and only then decide whether this ( starts a nested declarator or a
parameter list.

... except that we do it wrong and these attributes land on what will by
SYM_FN and not its first parameter.

BTW, the longer I'm looking at that, the less I like the original decision
to use __attribute__ for our extensions.  Or continued use of __attribute__
by gcc folks, while we are at it.

One lovely example:
	T __attribute__((whatever)) *p;
is NOT pointer-to-whatever-T; it's whatever-pointer-to-T.  Which is clearly
not what we want for __user et.al.  The only way to get it applied *before*
derivation is, BTW,
	T (__attribute__((whatever)) *p);
(and yes, that's where this crap in syntax has come from).  Mind you,
	T * __attribute__((whatever)) *p;
*is* pointer-to-whatever-pointer-to-T, which makes the situation even more
inconsistent.

While we are at it, our handling of __attribute__((mode(...))) is wrong -
not only
__attribute__((mode(HI)) long x;
is fine, it's actually s16.  Moreover,
int __attribute__((mode(HI)) *x;
is only going to work on 16bit boxen, since it's "16bit pointer to int".
64/32bit analogs of that construct *are* used in the wild on some weird
targets.

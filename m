From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix warnings from gcc 4.1.1
Date: Sat, 8 Jul 2006 11:14:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607081053560.3869@g5.osdl.org>
References: <20060708060004.20321.50429.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:25556 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964938AbWGHSO6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 8 Jul 2006 14:14:58 -0400
In-Reply-To: <20060708060004.20321.50429.stgit@dv.roinet.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org



On Sat, 8 Jul 2006, Pavel Roskin wrote:
> 
> These warnings are reported for every file:
> lib.h: In function 'add_symbol':
> lib.h:171: warning: value computed is not used

Please send a bug-report to the gcc people instead.

The code is correct, and the warning is bogus.

> That's the way new versions of gcc warn about values that are cast to a
> type but not used.

Yeah, and it's crap. The cast exists because we don't want to lose the 
type knowledge. Removing the cast would be wrong.

The fact that gcc warns about 

	(cast) a;

but does not warn about

	a;

is a sign of a gcc _bug_, and total insanity. The value is equally ignored 
in both cases.

> The cast in add_ptr_list_tag() is not really needed.  Its return value
> is used only in one place (add_pseudo) where it's converted to (void *)
> anyway.

Actually, _that_ is a bug.

The whole point of the cast is to not use a "void *", when we actually 
know exactly what kind of pointer the result is, and we want to do proper 
type-checking.

For example, when you do an "add_pseudo()", the return value should be a 
pointer to a pseudo_t.

So the declaration for "add_pseudo()" should be

	static inline pseudo_t *add_pseudo(struct pseudo_list **list, pseudo_t pseudo)

and we should never have cast it to "void *" since we know damn well what 
the result should be.

		Linus

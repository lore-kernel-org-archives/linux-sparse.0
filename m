From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] bloody mess with __attribute__() syntax
Date: Thu, 5 Jul 2007 17:43:34 +0100
Message-ID: <20070705164334.GM21478@ftp.linux.org.uk>
References: <20070705093528.GK21478@ftp.linux.org.uk> <468D1003.1050901@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761307AbXGEQnt@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <468D1003.1050901@freedesktop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Thu, Jul 05, 2007 at 08:36:35AM -0700, Josh Triplett wrote:
> Wow.  Insane.  So these all declare the same type:
> __attribute__((foo)) T *v;
> T __attribute__((foo)) *v;
> T *__attribute__((foo)) v;
> ?  Specifically, they point to a foo-T, for convenient shooting?

They all give you foo-pointer-to-T.  
	T (__attribute__((foo)) *v);
would give pointer-to-foo-T.

> context also represents a qualifier; the position of the qualifier should
> determine things like whether you want to enforce the context when you access
> a pointer or dereference a pointer.

Since __context__ is (sparse-only) keyword, we are not constrained by
anything anyway.
 
> > Frankly, I would rather add a new primitive (__qualifier__) mirroring the
> > __attribute__, but acting like real qualifiers do.  And switched the
> > noderef et.al. to it.
> 
> Something like that sounds vaguely reasonable.  It should allow the same set
> of attributes, and just change what they apply to.  To use your example,
> T __qualifier__((foo)) *v;
> and
> T (__attribute__((foo)) *v);
> would mean the same thing.

Yup, except that it would not accept storage-class-like attributes (e.g.
always_inline).  And yes, __qualifier__((context(...))) probably might
be a replacement for __context__, to reduce the number of primitives.

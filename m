From: Al Viro <viro@ftp.linux.org.uk>
Subject: [RFC] show_type() format problems
Date: Thu, 12 Jul 2007 10:14:53 +0100
Message-ID: <20070712091453.GY21668@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:54126 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207AbXGLJOy (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 12 Jul 2007 05:14:54 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I8ulB-0000Zo-JY
	for linux-sparse@vger.kernel.org; Thu, 12 Jul 2007 10:14:53 +0100
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

int __attribute__((address_space(1))) **p;
int *__attribute__((address_space(1))) *q;

void foo(void)
{
        p = q;
}

quite predictably gives a warning.  The contents of that warning,
however, is somewhat unfortunate:

test.c:6:4: warning: incorrect type in assignment (different address spaces)
test.c:6:4:    expected int **[addressable] [toplevel] p<asn:1>
test.c:6:4:    got int **[addressable] [toplevel] q<asn:1>

The reason is simple: we put <asn:...> *after* the identifier.  *, of
course, goes before it.  So when we have a pointer to pointer, there's
no way to tell which of them had brought address_space.

Do we want to keep the current behaviour?  It's obviously not nice -
especially when we get warnings like one above.

We also can't tell pointer to array from array of pointers.  Does anybody
object against making it look more like C declarations?  I.e. put <asn:...>
together with modifiers and at least add parens when needed?

Believe me, I do realize that it will change build logs.  I probably have
more of those than just about anybody else (several years worth of sparse
runs on the kernel for couple dozens of targets).  And yes, it'll hurt.
I don't see a better alternative, though; we might be able to tweak the
output to deal with ambiguities and still keep the same results for (very)
simple cases, but if we are tweaking it at all we really ought to go for
something recognizable for normal C programmers...

Comments?

From: Johannes Berg <johannes@sipsolutions.net>
Subject: packed struct sizeof wrong
Date: Fri, 28 May 2010 14:45:11 +0200
Message-ID: <1275050711.3909.102.camel@jlt3.sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:59056 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754171Ab0E1MpM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 28 May 2010 08:45:12 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <johannes@sipsolutions.net>)
	id 1OHyw3-00076B-MB
	for linux-sparse@vger.kernel.org; Fri, 28 May 2010 14:45:11 +0200
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi all,

I ran across this in some of my kernel code, and isolated it into a few
test cases, below. sparse should not report errors on this file, but
does regardless, somehow the structs appear larger to it than they are.

johannes

This is suitable for dropping into the validation directory:
--- begin file ---
struct A {
	unsigned char a, b, c, d;
} __attribute__((packed));

struct B {
	struct A A;
	unsigned char e, f;
	unsigned short g;
	unsigned char h;
} __attribute__((packed));

struct C {
	unsigned char a, b, c, d;
	unsigned char e, f;
	unsigned short g;
	unsigned char h;
} __attribute__((packed));

struct D {
	unsigned char h;
} __attribute__((packed));

struct E {
	unsigned short g;
	unsigned char h;
} __attribute__((packed));

#define BUILD_BUG_ON(expr) ((void)(sizeof(struct { int:-!!(expr); })))

static inline void foo(void)
{
	BUILD_BUG_ON(sizeof(struct A) != 4);
	BUILD_BUG_ON(sizeof(struct B) != 9);
	BUILD_BUG_ON(sizeof(struct C) != 9);
	BUILD_BUG_ON(sizeof(struct D) != 1);
	BUILD_BUG_ON(sizeof(struct E) != 3);
}

/*
 * check-name: packed struct sizeof
 */



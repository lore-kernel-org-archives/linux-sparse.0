From: josh@joshtriplett.org
Subject: Designated initializers for fields in anonymous structs and unions
Date: Thu, 31 Jul 2014 11:10:06 -0700
Message-ID: <20140731181006.GA13180@cloud>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:34992 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbaGaSKK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 31 Jul 2014 14:10:10 -0400
Received: from cloud (joshtriplett.org [IPv6:2604:3400:dc1:41:216:3eff:fe9f:2070])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 61921A80AF
	for <linux-sparse@vger.kernel.org>; Thu, 31 Jul 2014 20:10:07 +0200 (CEST)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

GCC 4.6 and newer support initializing designated initializers for fields in
anonymous structs and unions.  However, sparse does not.  Test case:

union U {
    int a;
    struct {
        int b;
        int c;
    };
};

static union U u = {
    .b = 0,
    .c = 0,
};

struct S {
    int a;
    union {
        int b;
        int c;
    };
};

static struct S s = {
    .a = 0,
    .b = 0,
};



GCC handles this just fine; sparse says:

test.c:10:6: error: unknown field name in initializer
test.c:11:6: error: unknown field name in initializer
test.c:24:6: error: unknown field name in initializer

Sparse needs to handle this, and we should add the above as a test case.

(We also need an appropriate extension to the test for
__attribute__((designated_init)).)

- Josh Triplett

From: Bernd Petrovitsch <bernd@sysprog.at>
Subject: modifier_string() inconsistency with modifiers
Date: Fri, 20 Aug 2010 12:33:48 +0200
Message-ID: <1282300429.10440.230.camel@thorin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:4719 "EHLO
	esgaroth.petrovitsch.priv.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752423Ab0HTKdw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 20 Aug 2010 06:33:52 -0400
Received: from [172.16.0.10] (chello062178036229.13.11.wu-wien.teleweb.at [62.178.36.229])
	(authenticated bits=0)
	by esgaroth.petrovitsch.priv.at (8.14.1/8.14.1) with ESMTP id o7KAXn0L022822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Fri, 20 Aug 2010 12:33:50 +0200
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi all!

To dump/print the modifiers, I just found the
modifier_string() function (in show-parse.c).

To the best of my understanding
----  snip  ----
	const char *res,**ptr, *names[] = {
		"auto", "register", "static", "extern",
		"const", "volatile", "[signed]", "[unsigned]",
		"[char]", "[short]", "[long]", "[long long]",
		"[typdef]", "[structof]", "[unionof]", "[enum]",
		"[typeof]", "[attribute]", "inline", "[addressable]",
		"[nocast]", "[noderef]", "[accessed]", "[toplevel]",
		"[label]", "[assigned]", "[type]", "[safe]",
		"[usertype]", "[force]", "[explicitly-signed]",
		NULL
	};
----  snip  ----
lists printable strings for the modifiers. The modifiers are bits
defined in symbol.h.
----  snip  ----
/* Modifiers */
#define MOD_AUTO	0x0001
#define MOD_REGISTER	0x0002
#define MOD_STATIC	0x0004
#define MOD_EXTERN	0x0008

#define MOD_CONST	0x0010
#define MOD_VOLATILE	0x0020
#define MOD_SIGNED	0x0040
#define MOD_UNSIGNED	0x0080

#define MOD_CHAR	0x0100
#define MOD_SHORT	0x0200
#define MOD_LONG	0x0400
#define MOD_LONGLONG	0x0800

#define MOD_TYPEDEF	0x1000
#define MOD_WEAK	0x2000

#define MOD_INLINE	0x40000
#define MOD_ADDRESSABLE	0x80000

#define MOD_NOCAST	0x100000
#define MOD_NODEREF	0x200000
#define MOD_ACCESSED	0x400000
#define MOD_TOPLEVEL	0x800000	// scoping..

#define MOD_LABEL	0x1000000
#define MOD_ASSIGNED	0x2000000
#define MOD_TYPE	0x4000000
#define MOD_SAFE	0x8000000	// non-null/non-trapping pointer

#define MOD_USERTYPE	0x10000000
#define MOD_FORCE	0x20000000
#define MOD_EXPLICITLY_SIGNED	0x40000000
#define MOD_BITWISE	0x80000000
----  snip  ----
Well, the equivalent for "MOD_WEAK" is "[structof]" - which seems wrong
to me.
And the parts for "inline" also doesn't fit AFAICS.

What did I actually miss?

	Bernd
-- 
mobile: +43 664 4416156              http://www.sysprog.at/
    Linux Software Development, Consulting and Services


From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: sparse-llvm: void return type compiles to i8
Date: Sun, 19 Aug 2012 02:32:00 +0200
Message-ID: <20120819003159.GB2880@debian.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:33342 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750878Ab2HSAcD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 18 Aug 2012 20:32:03 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>

Hi!

A simple function like this will compile to the following llvm bitcode:

	/* C */
	void func(void) {
		return;
	}

	/* LLVM */
	define i8 @func() {
	L0:
	  ret void
	}

The return type of the function and the type in the return instruction
don't match.

I found this inconsistency by running LLVM's bitcode validation on the
bitcode produced by sparse-llvm.


Greetings,
Jonathan Neusch=C3=A4fer
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

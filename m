From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [RFC][PATCH 0/3] implement pseudo->ctype
Date: Sat, 9 Jun 2012 15:12:27 +0300
Message-ID: <CAOJsxLEtW53C3fK86hw6mx0JjEYtsvnF=AmikzN9mFwMPM0oWQ@mail.gmail.com>
References: <1338792878-25898-1-git-send-email-xi.wang@gmail.com>
	<AE56D25F-20CE-49E3-90F8-2D80CA8CE4C9@gmail.com>
	<CAOJsxLGcqYO_H7vYB9Oku1s_3Nz9txytaB6ZjKCQ58o5G82Wag@mail.gmail.com>
	<2055A8E4-5846-4913-9E57-5BBDCB868284@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44989 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016Ab2FIMM1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Jun 2012 08:12:27 -0400
Received: by obbtb18 with SMTP id tb18so3821127obb.19
        for <linux-sparse@vger.kernel.org>; Sat, 09 Jun 2012 05:12:27 -0700 (PDT)
In-Reply-To: <2055A8E4-5846-4913-9E57-5BBDCB868284@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: linux-sparse@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Sat, Jun 9, 2012 at 2:52 PM, Xi Wang <xi.wang@gmail.com> wrote:
> BTW, I feel like LLVM's C interface is very incomplete. =A0I had to
> wrap some code in C++.

It'd probably be best to try to get the LLVM C API fixed upstream.
I've seen with the libcpu project what happens when you write your
core code in C but use the LLVM C++ APIs, and it's not pretty... ;-)
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC][PATCH 0/3] implement pseudo->ctype
Date: Sat, 09 Jun 2012 08:06:46 -0400
Message-ID: <4FD33C56.1080207@garzik.org>
References: <1338792878-25898-1-git-send-email-xi.wang@gmail.com> <AE56D25F-20CE-49E3-90F8-2D80CA8CE4C9@gmail.com> <CAOJsxLGcqYO_H7vYB9Oku1s_3Nz9txytaB6ZjKCQ58o5G82Wag@mail.gmail.com> <2055A8E4-5846-4913-9E57-5BBDCB868284@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60958 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab2FIMGu (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Jun 2012 08:06:50 -0400
Received: by yenm10 with SMTP id m10so1798010yen.19
        for <linux-sparse@vger.kernel.org>; Sat, 09 Jun 2012 05:06:50 -0700 (PDT)
In-Reply-To: <2055A8E4-5846-4913-9E57-5BBDCB868284@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: Pekka Enberg <penberg@kernel.org>, linux-sparse@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>

On 06/09/2012 07:52 AM, Xi Wang wrote:
> Besides, the phi nodes in sparse and LLVM are different.  LLVM's
> phi 1) requires one entry for each predecessor, and 2) must stay
> at the beginning of a block.  I didn't find an easy way to translate
> sparse's phi to LLVM's, so instead generated load/store for phi
> nodes.

That is reasonable.

	Jeff


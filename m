From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC/PATCH] sparse, llvm: Fix string globals access
Date: Sat, 09 Jun 2012 08:08:26 -0400
Message-ID: <4FD33CBA.4010903@garzik.org>
References: <1339160327-8534-1-git-send-email-penberg@kernel.org> <4FD240E2.6040003@garzik.org> <CAOJsxLH9N84YwLrHQXn+R1r4cOd7DUuM2SpFq828mSV6WmHjqg@mail.gmail.com> <35CC6868-F462-4116-A143-81959DA38D5C@gmail.com> <CAOJsxLFX-ZiDCQ84uKka4MYa_uUhLMPeR=XWAHMevTRFsfZBJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:59351 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598Ab2FIMI3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Jun 2012 08:08:29 -0400
Received: by gglu4 with SMTP id u4so1807556ggl.19
        for <linux-sparse@vger.kernel.org>; Sat, 09 Jun 2012 05:08:29 -0700 (PDT)
In-Reply-To: <CAOJsxLFX-ZiDCQ84uKka4MYa_uUhLMPeR=XWAHMevTRFsfZBJA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Xi Wang <xi.wang@gmail.com>, linux-sparse@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On 06/09/2012 07:00 AM, Pekka Enberg wrote:
> Jeff, I guess we should do this for output_load() and output_store()
> in sparse-llvm.c as well?


Yes, that is a definite improvement over the current hackery in 
output_op_load()


From: "Alexander Sorockin" <sorockin@yandex.ru>
Subject: Re: `char * s = "abc";' causes compile to crash with a segfault
Date: Thu, 30 Apr 2009 12:55:42 +0400
Message-ID: <op.us6y25squcb9g9@home-5db3af48a>
References: <op.us51m0w9ucb9g9@home-5db3af48a> <49F8C1EB.5010909@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from forwards2.yandex.ru ([213.180.200.23]:52709 "EHLO
	forwards2.yandex.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447AbZD3Izt (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 30 Apr 2009 04:55:49 -0400
Received: from smtp4.yandex.ru (smtp4.yandex.ru [213.180.223.136])
	by forwards2.yandex.ru (Yandex) with ESMTP id 1AA0946E026
	for <linux-sparse@vger.kernel.org>; Thu, 30 Apr 2009 12:55:47 +0400 (MSD)
Received: from net179.144.91-83.espenza.ru ([91.144.179.83]:48646 "EHLO
        home-5db3af48a" smtp-auth: "sorockin" TLS-CIPHER: <none> TLS-PEER-CN1:
        <none>) by mail.yandex.ru with ESMTP id S966707AbZD3Izo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Apr 2009 12:55:44 +0400
In-Reply-To: <49F8C1EB.5010909@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

On Thu, 30 Apr 2009 01:08:59 +0400, Jeff Garzik <jeff@garzik.org> wrote:

>
> As long as you don't do super-weird, non-standard C:  sure.
>

Hmm. It's interesting that sparse itself doesn't seem to compile with  
anything other that gcc. Does that mean that most other compilers are  
"non-standard"?

Sandy

From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] fix a memory leak in compile-i386.c
Date: Wed, 10 Aug 2011 01:41:49 -0400
Message-ID: <4E421A1D.1090008@garzik.org>
References: <20110809115554.GH7659@shale.localdomain> <1312892423-5178-1-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61631 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204Ab1HJFlz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Aug 2011 01:41:55 -0400
Received: by vws1 with SMTP id 1so588805vws.19
        for <linux-sparse@vger.kernel.org>; Tue, 09 Aug 2011 22:41:54 -0700 (PDT)
In-Reply-To: <1312892423-5178-1-git-send-email-j.neuschaefer@gmx.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?B?Sm9uYXRoYW4gTmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc: linux-sparse@vger.kernel.org, Dan Carpenter <error27@gmail.com>

On 08/09/2011 08:20 AM, Jonathan Neusch=C3=A4fer wrote:
> Don't allocate val twice in emit_divide.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer<j.neuschaefer@gmx.net>

Acked-by: Jeff Garzik <jgarzik@redhat.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

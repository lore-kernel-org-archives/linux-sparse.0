From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: Add 'leaf' to ignored attributes.
Date: Wed, 18 Jan 2012 00:33:08 -0800
Message-ID: <CANeU7QmjxS_Orua5-a5AON9pZENn0sC5ZNL0mAQH6UQrJeFuNw@mail.gmail.com>
References: <1326840431-27368-1-git-send-email-ethan@nicira.com>
	<CAOJsxLGNfSBZ9evmBaV6gN0rYorOUF85JJ9FNKXni01cvD1pVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35804 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756075Ab2ARIdJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 18 Jan 2012 03:33:09 -0500
Received: by ghbg16 with SMTP id g16so2803646ghb.19
        for <linux-sparse@vger.kernel.org>; Wed, 18 Jan 2012 00:33:08 -0800 (PST)
In-Reply-To: <CAOJsxLGNfSBZ9evmBaV6gN0rYorOUF85JJ9FNKXni01cvD1pVw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Ethan Jackson <ethan@nicira.com>, linux-sparse@vger.kernel.org

On Tue, Jan 17, 2012 at 11:20 PM, Pekka Enberg <penberg@kernel.org> wro=
te:
> On Wed, Jan 18, 2012 at 12:47 AM, Ethan Jackson <ethan@nicira.com> wr=
ote:
>> This patch adds the 'leaf' GCC attribute to the list of ignored
>> attributes. =A0Glibc uses this attribute causing the following
>> warnings in userspace projects:
>>
>> =A0/usr/include/stdlib.h:514:26: error: attribute '__leaf__': unknow=
n attribute
>>
>> Signed-off-by: Ethan Jackson <ethan@nicira.com>
>
> Acked-by: Pekka Enberg <penberg@kernel.org>

Looks good to me too. Will apply.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

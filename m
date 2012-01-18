From: Ethan Jackson <ethan@nicira.com>
Subject: Re: [PATCH] sparse: Add 'leaf' to ignored attributes.
Date: Wed, 18 Jan 2012 08:58:40 -0800
Message-ID: <CAEruU62B_FHaiPg5L9jHHMh=Qi0_zQcCYyu_DxLUnSmtsNF5BA@mail.gmail.com>
References: <1326840431-27368-1-git-send-email-ethan@nicira.com>
 <CAOJsxLGNfSBZ9evmBaV6gN0rYorOUF85JJ9FNKXni01cvD1pVw@mail.gmail.com> <CANeU7QmjxS_Orua5-a5AON9pZENn0sC5ZNL0mAQH6UQrJeFuNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44562 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932174Ab2ARQ7C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 18 Jan 2012 11:59:02 -0500
Received: by vbbfp1 with SMTP id fp1so2036386vbb.19
        for <linux-sparse@vger.kernel.org>; Wed, 18 Jan 2012 08:59:01 -0800 (PST)
In-Reply-To: <CANeU7QmjxS_Orua5-a5AON9pZENn0sC5ZNL0mAQH6UQrJeFuNw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Pekka Enberg <penberg@kernel.org>, linux-sparse@vger.kernel.org

Thanks!

Ethan

On Wed, Jan 18, 2012 at 00:33, Christopher Li <sparse@chrisli.org> wrot=
e:
> On Tue, Jan 17, 2012 at 11:20 PM, Pekka Enberg <penberg@kernel.org> w=
rote:
>> On Wed, Jan 18, 2012 at 12:47 AM, Ethan Jackson <ethan@nicira.com> w=
rote:
>>> This patch adds the 'leaf' GCC attribute to the list of ignored
>>> attributes. =A0Glibc uses this attribute causing the following
>>> warnings in userspace projects:
>>>
>>> =A0/usr/include/stdlib.h:514:26: error: attribute '__leaf__': unkno=
wn attribute
>>>
>>> Signed-off-by: Ethan Jackson <ethan@nicira.com>
>>
>> Acked-by: Pekka Enberg <penberg@kernel.org>
>
> Looks good to me too. Will apply.
>
> Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

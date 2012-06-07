From: Ethan Jackson <ethan@nicira.com>
Subject: Re: [PATCH] sparse: Add 'leaf' to ignored attributes.
Date: Thu, 7 Jun 2012 16:01:13 -0700
Message-ID: <CAEruU60SVmewoByN8+oL1Tautf+R9t-zMUTGoN8bxPeAg-FWUA@mail.gmail.com>
References: <1326840431-27368-1-git-send-email-ethan@nicira.com>
 <CAOJsxLGNfSBZ9evmBaV6gN0rYorOUF85JJ9FNKXni01cvD1pVw@mail.gmail.com>
 <CANeU7QmjxS_Orua5-a5AON9pZENn0sC5ZNL0mAQH6UQrJeFuNw@mail.gmail.com> <CAEruU62B_FHaiPg5L9jHHMh=Qi0_zQcCYyu_DxLUnSmtsNF5BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:38689 "HELO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755392Ab2FGXBf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 7 Jun 2012 19:01:35 -0400
Received: by mail-vc0-f178.google.com with SMTP id m8so806167vcd.37
        for <linux-sparse@vger.kernel.org>; Thu, 07 Jun 2012 16:01:34 -0700 (PDT)
In-Reply-To: <CAEruU62B_FHaiPg5L9jHHMh=Qi0_zQcCYyu_DxLUnSmtsNF5BA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Pekka Enberg <penberg@kernel.org>, linux-sparse@vger.kernel.org

Hello, sorry to have left this hanging so long.  Out of curiosity, is
this still planned to be applied to the upstream tree?

Ethan

On Wed, Jan 18, 2012 at 8:58 AM, Ethan Jackson <ethan@nicira.com> wrote=
:
> Thanks!
>
> Ethan
>
> On Wed, Jan 18, 2012 at 00:33, Christopher Li <sparse@chrisli.org> wr=
ote:
>> On Tue, Jan 17, 2012 at 11:20 PM, Pekka Enberg <penberg@kernel.org> =
wrote:
>>> On Wed, Jan 18, 2012 at 12:47 AM, Ethan Jackson <ethan@nicira.com> =
wrote:
>>>> This patch adds the 'leaf' GCC attribute to the list of ignored
>>>> attributes. =A0Glibc uses this attribute causing the following
>>>> warnings in userspace projects:
>>>>
>>>> =A0/usr/include/stdlib.h:514:26: error: attribute '__leaf__': unkn=
own attribute
>>>>
>>>> Signed-off-by: Ethan Jackson <ethan@nicira.com>
>>>
>>> Acked-by: Pekka Enberg <penberg@kernel.org>
>>
>> Looks good to me too. Will apply.
>>
>> Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

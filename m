From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] recognize binary constants
Date: Wed, 16 Nov 2011 17:36:40 -0800
Message-ID: <CANeU7QnysJkdW0hdtYzGh5KNgVDy5y-8cX0o2q9oi1HiLBEoew@mail.gmail.com>
References: <1315434714.1892.7.camel@marconi>
	<20110908170734.GB17041@mwanda>
	<CA+_b7D+qrLK4EfDjf+gPM+291Khhz6EuJakT=N4N1R3HSHq+Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54703 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755212Ab1KQBgk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 16 Nov 2011 20:36:40 -0500
In-Reply-To: <CA+_b7D+qrLK4EfDjf+gPM+291Khhz6EuJakT=N4N1R3HSHq+Nw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: linux-sparse@vger.kernel.org, Kamal Mostafa <kamal@canonical.com>, smatch@vger.kernel.org

On Tue, Nov 15, 2011 at 11:35 AM, Dan Carpenter <error27@gmail.com> wro=
te:
> On 9/8/11, Dan Carpenter <error27@gmail.com> wrote:
>> Sparse doesn't parse binary constants properly so the following code
>> generates an error:
>>
>> =A0 =A0 =A0 x =3D 0b11;
>>
>> test.c:5:17: error: constant 0b11 is not a valid number
>>
>> Reported-by: Kamal Mostafa <kamal@canonical.com>
>> Signed-off-by: Dan Carpenter <error27@gmail.com>
>
> I sent this patch before but the git tree was offline so everything
> was dead.

Thanks for the reminder. The patch looks fine.

I will apply it.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

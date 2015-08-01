From: Tony Camuso <tcamuso@redhat.com>
Subject: Re: [PATCH 3/3] Add NOWARN and NOERR compile conditions
Date: Sat, 1 Aug 2015 07:09:06 -0400
Message-ID: <55BCA8D2.1040808@redhat.com>
References: <1438216001-8862-1-git-send-email-tcamuso@redhat.com>
 <1438216001-8862-4-git-send-email-tcamuso@redhat.com>
 <20150730025502.GA1692@x> <55BA0E4E.7000508@redhat.com>
 <CANeU7Qm=nv85N6MWZ=Lo=OLWEmyEOOk84AHbBwFAgfUfhBonbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44924 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210AbbHALJH (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 1 Aug 2015 07:09:07 -0400
In-Reply-To: <CANeU7Qm=nv85N6MWZ=Lo=OLWEmyEOOk84AHbBwFAgfUfhBonbg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On 07/31/2015 07:46 PM, Christopher Li wrote:
> On Thu, Jul 30, 2015 at 4:45 AM, Tony Camuso <tcamuso@redhat.com> wrote:
>>
>> I thought it would be less intrusive, since I don't know how useful
>> this would be to others.
>>
>> If you prefer a switch, I will do that.
>
> I agree that this should be run time behavior.
>
> +
> +#if defined NOWARN || defined NOERR
> +               return token->next;
> +#else
>
> What is up with this change? It is not output warning or not.
> It affect the parsing as well. If sparse can't bail out properly,
> this should be a separate patch.
>
> Chris
>

Hi, Chris.

I've since submitted a runtime patch (3/3 V3) with a switch as a
response to this patch, but it basically does the same thing here.

Consider the case where the source contains something like this...

	struct foo {
		union {
			int number;
			int *pointer;
		};
	};

There being no ident for the union within the struct, we get the warning,
"missing identifier in declaration" etc.

Code without the patch.

	/* Just a type declaration? */
	if (!ident) {
		warning(token->pos, "missing identifier in declaration");
		return expect(token, ';', "at the end of type declaration");
	}
  
Regards,
Tony


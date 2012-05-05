From: Konrad Eisele <eiselekd@gmail.com>
Subject: Re: dependency tee from c parser entities downto token
Date: Sat, 05 May 2012 10:56:17 +0200
Message-ID: <4FA4EB31.5000607@gmail.com>
References: <4F967865.60809@gaisler.com> <CANeU7Qku=Zk3OfY3h45M+ecu11A6eTH0Y0+9wwj9Fmu8TyWwRw@mail.gmail.com> <CAEjhO7+EKvFHmpcFHrweGQEa4SHf62AAy5_SyhSxD1bcguafyw@mail.gmail.com> <CANeU7QkWbvT-NN5vm=JXnmfDpbzNzTjNYxkB8GJsKCysiOe8tQ@mail.gmail.com> <4FA38635.5060300@gaisler.com> <CANeU7QnVjEmZC2SNX-arWP7ovRx1mgNRyQSe7N2STGa-5u=i7A@mail.gmail.com> <4FA3B14A.3070609@gaisler.com> <4FA3CD58.80809@gmail.com> <20120504153054.GA5994@leaf> <4FA441E0.6010701@gmail.com> <CANeU7QkoHY_L9oQ4WuxPFUABwFznTfAMWMSRz7-Pe98dSiuiGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:64042 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750987Ab2EEIwr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 5 May 2012 04:52:47 -0400
Received: by lahj13 with SMTP id j13so2520465lah.19
        for <linux-sparse@vger.kernel.org>; Sat, 05 May 2012 01:52:45 -0700 (PDT)
In-Reply-To: <CANeU7QkoHY_L9oQ4WuxPFUABwFznTfAMWMSRz7-Pe98dSiuiGQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Konrad Eisele <konrad@gaisler.com>, linux-sparse@vger.kernel.org

On 05/05/2012 12:30 AM, Christopher Li wrote:
> On Fri, May 4, 2012 at 1:53 PM, Konrad Eisele<eiselekd@gmail.com>  wrote:
>> make C=2:
>>
>> original sparse:
>> real    17m54.997s
>> user    15m25.181s
>> sys     2m11.281s
>>
>> decpp-sparse from "git clone git://git.code.sf.net/p/decpp/code decpp "
>> real    18m29.748s
>> user    16m18.155s
>> sys     2m13.221s
>>
>> But decpp is not written with performance in common cases in mind.
>> The 2 runs probably also depend on other factors too.
>> I cant think that 4 bytes extra for each token can have a big impact,
>> if I would implement it that way (it is not in decpp).
>
> The deal breaker is not able to free token list if other program using
> sparse don't need it. I believe that I have an alternative approach
> allow you do want you want while keeping the impact to sparse
> internal small. In my mind, that is straightly better than your
> current patch. I can share more details if you found a missing link.
>
>> I understand. Actually the code to demonstrate is
>> git://git.code.sf.net/p/decpp/code , then do a
>> $make
>> $./shrinkc t1.c
>> That is kind of the goal.
>> And - it does require some  internal structure
>> change. You dont get this kind of functionality
>> for free. You have to be invasive, isnt this
>> something that is obvious?. And in my view, it
>> can come with penalty. The preprocessing stage
>
> That doesn't mean that we should pay any penalty
> for it. Especially I believe there is better alternative
> approach to allow you do what you want and keep
> the API clean. You need to be a little patient here
> to understand my alternative suggestions. I did spend
> some time here to come up with the approach to make
> it works for you and keep myself happy about the internals.
>
> You dismiss the my suggestion too eagerly without
> considering how to make it work. You are pretty much saying,
> "Nah, this is not going to work, I am calling in the big hammers."
> You should at least consider it, point out where you think
> it doesn't work, so that I can provide addition details how
> to make it work. I did notice that I have some detail left out in
> my suggestions, mostly due to time constrain to write it up.
>
> Chris
>

I'm willing to learn, I'll implement your token<pos> scheme,
see the other mail just sent on that subject
-- Konrad



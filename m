From: Edward Cree <ecree@solarflare.com>
Subject: Re: Casting 0 to a __bitwise type
Date: Fri, 17 Feb 2017 14:56:37 +0000
Message-ID: <f43f547a-4437-a4ea-08fb-3a09d3437918@solarflare.com>
References: <9c361aab-ee4b-8309-ff1a-b0e65bb93c5d@solarflare.com>
 <20170214225127.gxvtfnbe5dkqp4lq@macbook.local>
 <5dcaea41-102c-ce1f-a4eb-6c1b917ba31c@solarflare.com>
 <20170217123744.jtog4rwpt6k6pyg3@macbook.local>
 <76b5465a-ef93-0ab1-f81a-c2d4c406482f@solarflare.com>
 <20170217141613.ndkbib7a3cjz7y4n@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nbfkord-smmo02.seg.att.com ([209.65.160.78]:61367 "EHLO
        nbfkord-smmo02.seg.att.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933885AbdBQO4q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 17 Feb 2017 09:56:46 -0500
In-Reply-To: <20170217141613.ndkbib7a3cjz7y4n@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org

On 17/02/17 14:16, Luc Van Oostenryck wrote:
> On Fri, Feb 17, 2017 at 01:13:51PM +0000, Edward Cree wrote:
>> So can you explain to me why 0 should be treated specially by _everything
>>  except_ the cast operator?
> It was a design decision, justified (I think) by:
> - 0 is already magic in C (can be used to initialize integer *and* pointers)
> - since 0 is a constant that make sense for all sizes, have the same
>   representation in big endian and little endian, ... it can be used for
>   all bitwise types.
I agree so far: 0 is special...
> I think the answer to your question could be: "since it's best to avoid casts,
> especially unnneded ones for 0 zero you don't need a cast, it's good to warn
> about it".
...but suddenly in a cast it's not special any more?

I _do_ need a cast, because once I've got a zero of type __be32 I then want to
 operate on it, specifically by taking its complement - which of course is an
 entirely legal thing to do with a bitwise type.
And the cast has to be there, because sparse doesn't accept "__be32 x = ~0;" and
 quite rightly too as integer promotions make it nontrivial to determine whether
 that is correct.  The complement operation is only bitwise-safe if applied to a
 bitwise type, hence the type conversion must happen before the complement.
Anyway, after digging my way around innards of sparse I've come up with a patch
 that appears to do what I want, I'll post it as a new thread.  Then we'll have
 something slightly more concrete to argue about ;)

-Ed

PS. I've also noticed that sparse doesn't seem to pay attention to the -Wbitwise
 command line option any more, it always performs the bitwise checks whether the
 user asked for them or not.  The only results for "git grep Wbitwise" are the
 code to parse the option, command lines in regression tests, and the man page.
Personally that doesn't bother me, because I want the checks enabled anyway, but
 I suppose it's a bug that they can't be turned off.
--
The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.

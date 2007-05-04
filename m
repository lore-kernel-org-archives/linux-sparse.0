From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: Re: Listing special marked symbols - attribute section
Date: Fri, 4 May 2007 11:29:00 -0700
Message-ID: <70318cbf0705041129m26578c25o42d701241651e8de@mail.gmail.com>
References: <70318cbf0705031537o4afd1bf8v39635e38c32548c8@mail.gmail.com>
	 <OF57D459CC.B2C8F8FC-ONC12572D1.0046C7DF-C12572D1.004837A5@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.227]:20372 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161497AbXEDS3B (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 4 May 2007 14:29:01 -0400
Received: by wr-out-0506.google.com with SMTP id 76so991363wra
        for <linux-sparse@vger.kernel.org>; Fri, 04 May 2007 11:29:00 -0700 (PDT)
In-Reply-To: <OF57D459CC.B2C8F8FC-ONC12572D1.0046C7DF-C12572D1.004837A5@br-automation.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Schmid <Thomas.Schmid@br-automation.com>
Cc: linux-sparse@vger.kernel.org

On 5/4/07, Thomas Schmid <Thomas.Schmid@br-automation.com> wrote:
> A little bit offtopic: Because attribute section is ignored, i tried to
> mis-use attribute context (dirty, i know).
> I tried to find out the meaning of attribute context - but i couldn't.
> What is its purpose?

If you want to do some quick and dirty hack. I suggest you just add your
section attribute as a new member.

The context attribute is used for declare function which has impact on the
context counting. e.g. from compiler.h:

# define __acquires(x)  __attribute__((context(x,0,1)))
# define __releases(x)  __attribute__((context(x,1,0)))

Chris

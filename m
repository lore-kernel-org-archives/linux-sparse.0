From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Re: Ignore the ms_abi/sysv_abi attributes.
Date: Wed, 30 Sep 2009 22:21:30 +0200
Message-ID: <4AC3BDCA.9090300@redhat.com>
References: <20090929210106.GA3592@redhat.com> <70318cbf0909291630q73f92ab9ma980ca98564f366f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46084 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899AbZI3UV3 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 30 Sep 2009 16:21:29 -0400
In-Reply-To: <70318cbf0909291630q73f92ab9ma980ca98564f366f@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On 09/30/2009 01:30 AM, Christopher Li wrote:
> On Tue, Sep 29, 2009 at 2:01 PM, Michael Stefaniuc<mstefani@redhat.com>  wrote:
>> This is needed for getting a meaningful sparse run on a Wine 64-bit
>> compile. Else the basic Win32 headers will produce tons of
>> error: attribute 'ms_abi': unknown attribute
>> which end in
>> error: too many errors.
>>
>> The sysv_abi attribute was just added for symmetry.
>
> Thanks for the patch. Ignoring the attribute has become so common now.
> I decide stop the complicate way to adding ignored attributes.
>
> I attach two patches to simplify things. I am I am going to push
> them out to chrisl tree.
>
> Can you change your patch base on my new patch?
Done!

> It should be really simple, just add one string for each attribute
> is good enough.
The nicest part about this is that the ignored attributes are now sorted 
alphabetically and one doesn't have to figure out where exactly to add them.

thanks
bye
	michael

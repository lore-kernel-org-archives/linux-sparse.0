From: Nicolai Stange <nicstange@gmail.com>
Subject: Re: [PATCH RFC 07/13] evaluate: check static storage duration objects' intializers' constness
Date: Sat, 09 Jan 2016 23:28:08 +0100
Message-ID: <8737u6wfpj.fsf@gmail.com>
References: <871tfzkcgi.fsf@gmail.com> <20160109180450.GA2718@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33071 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756068AbcAIW2L (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Jan 2016 17:28:11 -0500
Received: by mail-wm0-f66.google.com with SMTP id u188so20848888wmu.0
        for <linux-sparse@vger.kernel.org>; Sat, 09 Jan 2016 14:28:10 -0800 (PST)
In-Reply-To: <20160109180450.GA2718@macpro.local> (Luc Van Oostenryck's
	message of "Sat, 9 Jan 2016 19:04:51 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Nicolai Stange <nicstange@gmail.com>, linux-sparse@vger.kernel.org

Luc Van Oostenryck <luc.vanoostenryck@gmail.com> writes:

> On Thu, Jul 23, 2015 at 01:19:09AM +0200, Nicolai Stange wrote:
>> Initializers of static storage duration objects shall be constant
>> expressions [6.7.8(4)].
>> 
>> Warn if that requirement is not met.
>> 
>> Identify static storage duration objects by having either of
>> MOD_TOPLEVEL or MOD_STATIC set.
>> 
>> Check an initializer's constness at the lowest possible subobject
>> level, i.e. at the level of the "assignment-expression" production
>> in [6.7.8].
>> 
>> For compound objects, make handle_list_initializer() pass the
>> surrounding object's storage duration modifiers down to
>> handle_simple_initializer() at subobject initializer evaluation.
>
>
> This patch makes validation/{builtin_bswap,choose_expr}.c fail.
> Of course, it's directly related to the purpose of the patch but
> then the test should be adapted.
>

Yes, you are absolutely right. However, as mentioned in this RFC series'
cover letter, I decided to leave these two failers as is "for the
moment". Certainly this is anything but best practice and I can only
apologize for sending you half (well 97%) baken patches -- and promise
to never do it again...

From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: [PATCH 0/10] Sparse linker
Date: Thu, 4 Sep 2008 17:35:45 +0400
Message-ID: <f19298770809040635s611ef3c3sa05111743ea60631@mail.gmail.com>
References: <1220478954-22678-1-git-send-email-alexey.zaytsev@gmail.com>
	 <70318cbf0809031808u8610f3h4b3d53a7b76a7799@mail.gmail.com>
	 <70318cbf0809031816m69565c5aj9417d9a2e136770d@mail.gmail.com>
	 <f19298770809032103h5ea34122g44fda595d775cecf@mail.gmail.com>
	 <70318cbf0809040027i79476a4ds3d1086f5ca434d9d@mail.gmail.com>
	 <f19298770809040241h39703754i5bcac349e1d151c6@mail.gmail.com>
	 <70318cbf0809040335k5ea24032sffc11a8793b43b40@mail.gmail.com>
	 <f19298770809040629t1eb86f2co66a87e564bcd8684@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:64892 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbYIDNfr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 4 Sep 2008 09:35:47 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1896655yxm.1
        for <linux-sparse@vger.kernel.org>; Thu, 04 Sep 2008 06:35:46 -0700 (PDT)
In-Reply-To: <f19298770809040629t1eb86f2co66a87e564bcd8684@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>, Codrin Alexandru Grajdeanu <grcodal@gmail.com>

On Thu, Sep 4, 2008 at 5:29 PM, Alexey Zaytsev <alexey.zaytsev@gmail.com> wrote:
> On Thu, Sep 4, 2008 at 2:35 PM, Christopher Li <sparse@chrisli.org> wrote:
>> On Thu, Sep 4, 2008 at 2:41 AM, Alexey Zaytsev <alexey.zaytsev@gmail.com> wrote:
>>> No, that's not how it works. ;)
>>> Please compile and run the code. And look at what is actually generated.
>>> Or wait a bit, I'll try to describe the serialization process in more detail.
>>>
>>
>> I did. It generate C *source* code like this:
>>
>> =============cut =============
>> #include "test.sparse_declarations.c"
>>
>> #define NULL ((void *)0)
>> static struct a_wrapper __a_0 = {
>>        .payload = {
>>                .d = 1,
>>                .b_ptr = &__b_0.payload,
>>        },
>> };
>> static struct b_wrapper __b_0 = {
>>        .payload = {
>>                .k = 11,
>>                .a_ptr = &__a_1.payload,
>>        },
>> };
>> ============ paste ===========
>>
>> I assume you intend to use a real compiler(gcc) to compile
>> and link that code, no?
>>
>> I haven't fully understand how you use that piece of C code. But my
>> gut feeling is that we shouldn't need to do that C source code
>> generation at all.
> Ok, let me try to explain how the stuff works. Please note that in

Ugh, my pretty code listings got corrupted by the bloody gmail.
Here is a better version: http://zaytsev.su/explanation.txt

From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: [PATCH 0/10] Sparse linker
Date: Thu, 4 Sep 2008 13:41:13 +0400
Message-ID: <f19298770809040241h39703754i5bcac349e1d151c6@mail.gmail.com>
References: <1220478954-22678-1-git-send-email-alexey.zaytsev@gmail.com>
	 <70318cbf0809031808u8610f3h4b3d53a7b76a7799@mail.gmail.com>
	 <70318cbf0809031816m69565c5aj9417d9a2e136770d@mail.gmail.com>
	 <f19298770809032103h5ea34122g44fda595d775cecf@mail.gmail.com>
	 <70318cbf0809040027i79476a4ds3d1086f5ca434d9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:33280 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431AbYIDJlO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 4 Sep 2008 05:41:14 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3210197rvb.1
        for <linux-sparse@vger.kernel.org>; Thu, 04 Sep 2008 02:41:13 -0700 (PDT)
In-Reply-To: <70318cbf0809040027i79476a4ds3d1086f5ca434d9d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>, Codrin Alexandru Grajdeanu <grcodal@gmail.com>

On Thu, Sep 4, 2008 at 11:27 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Wed, Sep 3, 2008 at 9:03 PM, Alexey Zaytsev <alexey.zaytsev@gmail.com> wrote:
>> If I understand the question right, no. Every "sparse object" .so has a
>> "struct ptr_list *symbols" entry (in fact, the only non-static entry) that
>> points to the serialized ptr list of the "struct sold_symbol". The linker
>> dlopen()'s the .so and hooks to the entry, for every input object file.
>> After that, it simply calls ptr_list_concat() on the opened symbol lists,
>> and serializes the resulting combined list. There is of course nothing
>> wrong if we modify the data obtained from the .so, as it is cow-mmaped.
> ...
>> Well, I serialize the data into C, and then compile it into .so, if
>> that was the question. You might want to apply the first patch
>> and look at the serialization-test output.
>
> OK. I just realized that you are building a completely different kind
> of "linker" than I have in mind.
>
> Generate C source file and let gcc to compile and link it is an
> interesting idea. But I think it is a step back wards.
>

No, that's not how it works. ;)
Please compile and run the code. And look at what is actually generated.
Or wait a bit, I'll try to describe the serialization process in more detail.

From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH 0/10] Sparse linker
Date: Thu, 4 Sep 2008 00:27:40 -0700
Message-ID: <70318cbf0809040027i79476a4ds3d1086f5ca434d9d@mail.gmail.com>
References: <1220478954-22678-1-git-send-email-alexey.zaytsev@gmail.com>
	 <70318cbf0809031808u8610f3h4b3d53a7b76a7799@mail.gmail.com>
	 <70318cbf0809031816m69565c5aj9417d9a2e136770d@mail.gmail.com>
	 <f19298770809032103h5ea34122g44fda595d775cecf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:1727 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbYIDH1l (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 4 Sep 2008 03:27:41 -0400
Received: by fg-out-1718.google.com with SMTP id 19so355083fgg.17
        for <linux-sparse@vger.kernel.org>; Thu, 04 Sep 2008 00:27:40 -0700 (PDT)
In-Reply-To: <f19298770809032103h5ea34122g44fda595d775cecf@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>, Codrin Alexandru Grajdeanu <grcodal@gmail.com>

On Wed, Sep 3, 2008 at 9:03 PM, Alexey Zaytsev <alexey.zaytsev@gmail.com> wrote:
> If I understand the question right, no. Every "sparse object" .so has a
> "struct ptr_list *symbols" entry (in fact, the only non-static entry) that
> points to the serialized ptr list of the "struct sold_symbol". The linker
> dlopen()'s the .so and hooks to the entry, for every input object file.
> After that, it simply calls ptr_list_concat() on the opened symbol lists,
> and serializes the resulting combined list. There is of course nothing
> wrong if we modify the data obtained from the .so, as it is cow-mmaped.
...
> Well, I serialize the data into C, and then compile it into .so, if
> that was the question. You might want to apply the first patch
> and look at the serialization-test output.

OK. I just realized that you are building a completely different kind
of "linker" than I have in mind.

Generate C source file and let gcc to compile and link it is an
interesting idea. But I think it is a step back wards.

For starts, how do you handle the case that the symbol from your
input file have conflict on the function define in the loader itself?

If I understand your plan correctly, I don't see how it can handle
the following case:

file a.c:

void foo(void) {
    printf("%p\n", &bar);
}

file b.c

bar() {
    printf("%p\n", &foo);
}

So do you put the extern symbol in your .so as symbol as well?
If you don't, how do you link the extern symbol to where it is defined?

If you do, then you can't load a.so alone because "bar" symbol is not
resolved. And you can't load b.so because "foo" symbol can't resolve.

If you link a.o and b.o together into ab.so. Then you pretty much need to
link the whole linux kernel (except the modules) into one flat file. It defeat
the purpose of having the linker and loader to load single sparse object
file one at a time. Ideally the checker should be able to dynamic load the
sparse object file only when it is needed.

Chris

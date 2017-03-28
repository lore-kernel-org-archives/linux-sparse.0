From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Suggest new opcode to help with initialization of aggregate types:
 Was: sparse-llvm initialization of local vars
Date: Tue, 28 Mar 2017 15:52:18 +0100
Message-ID: <CACXZuxesdmj6kJSEtK90zqdks9pmw9WwZPYF1F9tzF9XnHfiiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36681 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbdC1Owk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 10:52:40 -0400
Received: by mail-oi0-f47.google.com with SMTP id r203so40935647oib.3
        for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2017 07:52:25 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

On 26 March 2017 at 23:04, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> I noticed that when local variables are initialized, only explicit
> initialization instructions are output. But I think C requires that
> the whole object be zeroed out as well.
>
> Example code:
>
> extern int printf(const char *s, ...);
>
> struct foo {
> long long int i,j;
> };
>
> static void dosomething(struct foo *foo)
> {
> printf("foo->i = %lld, foo->j = %lld\n", foo->i, foo->j);
> }
>
> int main(void)
> {
> struct foo foo = { 1, 2 };
> struct foo bar = { 99 };
> dosomething(&foo);
> dosomething(&bar);
> return 0;
> }
>
> In this example, sparse-llvm outputs garbage value for bar->j whereas
> it should be 0.
>
> To fix this, before any instructions for initialization is run,
> sparse-llvm should zero out the whole object using LLVM intrinsic such
> as memset. This is implemented in my repository.
>

It may be better to have the linearizer output an explicit instruction
to zero out the aggregate type when an initializer is present. This
might help with the simplification phase as well - for example with
the issue I reported:

http://marc.info/?l=linux-sparse&m=149070715427276&w=2

Thanks and Regards
Dibyendu

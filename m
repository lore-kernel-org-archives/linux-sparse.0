From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm initialization of local vars
Date: Sun, 26 Mar 2017 23:04:13 +0100
Message-ID: <CACXZuxfw4G5j40zB98d7YuRXttKYY7zyzok4KK821qE4+QgEBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:38363 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbdCZWEU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 26 Mar 2017 18:04:20 -0400
Received: by mail-it0-f45.google.com with SMTP id y18so34813427itc.1
        for <linux-sparse@vger.kernel.org>; Sun, 26 Mar 2017 15:04:19 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I noticed that when local variables are initialized, only explicit
initialization instructions are output. But I think C requires that
the whole object be zeroed out as well.

Example code:

extern int printf(const char *s, ...);

struct foo {
long long int i,j;
};

static void dosomething(struct foo *foo)
{
printf("foo->i = %lld, foo->j = %lld\n", foo->i, foo->j);
}

int main(void)
{
struct foo foo = { 1, 2 };
struct foo bar = { 99 };
dosomething(&foo);
dosomething(&bar);
return 0;
}

In this example, sparse-llvm outputs garbage value for bar->j whereas
it should be 0.

To fix this, before any instructions for initialization is run,
sparse-llvm should zero out the whole object using LLVM intrinsic such
as memset. This is implemented in my repository.

Regards
Dibyendu

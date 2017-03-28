From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm array size computation issue
Date: Tue, 28 Mar 2017 21:25:21 +0100
Message-ID: <CACXZuxdBRB+mvRJf3VGLK2Po8w9gvSXkjTnt3=UCfoa2Wqm5Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:38708 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753330AbdC1UZX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 16:25:23 -0400
Received: by mail-it0-f47.google.com with SMTP id y18so34237748itc.1
        for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2017 13:25:22 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I am investigating an issue with following test case:

int main(void)
{
const char *names[] = {
"dibyendu",
"majumdar",
NULL,
};
return 0;
}

The issue here is that sparse-llvm thinks the array size is zero:

define i32 @main() {
L0:
  %names_0000026DE9D2DDA8. = alloca [0 x i8*]

It appears that sparse is correctly calculating the size of the array
in examine_node_type() in symbol.c, but by the time the symbol gets to
sparse-llvm the bit_size is somehow changed to -1. I haven't yet
tracked down where this is happening.

Thanks and Regards
Dibyendu

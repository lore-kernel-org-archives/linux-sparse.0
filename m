From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm incorrect definition of local variables
Date: Tue, 7 Mar 2017 00:08:22 +0000
Message-ID: <CACXZuxdH3tryp92DVHhd8zs9bUTbrAs92Pz+knnDqDzj4eXWYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:32959 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754172AbdCGAlX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Mar 2017 19:41:23 -0500
Received: by mail-it0-f41.google.com with SMTP id w124so4796787itb.0
        for <linux-sparse@vger.kernel.org>; Mon, 06 Mar 2017 16:39:33 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

When I try to compile following in sparse-llvm:

int main(const char *argv[]) {
 int values[5];
 values[0] = 9;
 values[1] = 8;
 values[2] = 7;
 values[3] = 6;
 values[4] = 5;
 int *p = &values[4];
 return (*p == 5) ? 0 : 1;
}

I get:

@values = external global [5 x i32]
define i32 @main(i8**) {
L0:
  store i32 9, i32* getelementptr inbounds ([5 x i32], [5 x i32]*
@values, i32 0, i32 0)
  store i32 8, i32* bitcast (i8* getelementptr inbounds (i8, i8*
bitcast ([5 x i32]* @values to i8*), i64 4) to i32*)
  store i32 7, i32* bitcast (i8* getelementptr inbounds (i8, i8*
bitcast ([5 x i32]* @values to i8*), i64 8) to i32*)
  store i32 6, i32* bitcast (i8* getelementptr inbounds (i8, i8*
bitcast ([5 x i32]* @values to i8*), i64 12) to i32*)
  store i32 5, i32* bitcast (i8* getelementptr inbounds (i8, i8*
bitcast ([5 x i32]* @values to i8*), i64 16) to i32*)
  ret i32 0
}

Here 'values' has been defined above as external global, whereas it
should be allocated on the stack.

Regards
Dibyendu

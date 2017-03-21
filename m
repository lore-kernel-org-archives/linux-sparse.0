From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Another potential issue with linearized output
Date: Tue, 21 Mar 2017 22:21:50 +0000
Message-ID: <CACXZuxc9eMUN1HVVUCTG82qMe_ZkzjhJzivdMNN_nhDzi-j3OA@mail.gmail.com>
References: <CACXZuxetXE1QQ2jK5Pc5+FQB-vN3pguUNm8FuJ5hZ23C845KKA@mail.gmail.com>
 <CACXZuxfdKn-x_-nVbLy4PGMpmVDk-_7RESOQcfPT8FLa7JDEzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:36850 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933105AbdCUWVw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 21 Mar 2017 18:21:52 -0400
Received: by mail-it0-f52.google.com with SMTP id w124so16425650itb.1
        for <linux-sparse@vger.kernel.org>; Tue, 21 Mar 2017 15:21:51 -0700 (PDT)
In-Reply-To: <CACXZuxfdKn-x_-nVbLy4PGMpmVDk-_7RESOQcfPT8FLa7JDEzQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

On 21 March 2017 at 21:41, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> On 21 March 2017 at 15:54, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
>> When I try to compile following test (see link) in sparse-llvm - LLVM says:
>>
>> Instruction does not dominate all uses!
>>   %load_target = load i32, i32* %191
>>   %R122 = icmp eq i32 %load_target4, %load_target
>> Instruction does not dominate all uses!
>>   %load_target = load i32, i32* %191
>>   %R283 = icmp eq i32 %load_target4, %load_target
>> Instruction does not dominate all uses!
>>   %load_target = load i32, i32* %191
>>   %R522 = icmp eq i32 %load_target4, %load_target
>>
>> I have not yet investigated what the issue is but I thought it best to
>> post the test case so that it can be validated.
>>
>> https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/bugs/cq3.c
>>
>
> Appears that the problem is occurring in simplify_one_symbol().
>

I have tracked this down to the treatment of variable n2 (looking only
at the first function regc() for now).

The C code looks like this:

   for (j=0; j<22; j++)
     switch (s) {
       case 1: if (d[j] != n1) {
                n2 = d[j];
                s = 2;
                nr = 1;
               }
               break;
       case 2: if (d[j] == n1) {
                s = 3;
                break;
               }
               if (d[j] == n2) {
                nr = nr+1;
                break;
               }
               s = 4;
               break;
       case 3: if (d[j] != n1) s = 4;
               break;
     }
   ;

Although there is 1 store and 1 load of n2, the attempt to convert the
load to a pseudo and kill the store seems wrong. Perhaps the
simplification is not taking into account the jumps here due to the
switch? I am not sure how to fix this issue. Ideas?

Thanks and Regards
Dibyendu

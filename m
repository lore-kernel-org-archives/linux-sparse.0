From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Another code snippet that Sparse has problems with
Date: Thu, 7 Sep 2017 11:18:10 +0100
Message-ID: <CACXZuxceJuvMPZKZbLXDrzsXWK2a9A8M8L4rFaJ0f-s7vL-1vQ@mail.gmail.com>
References: <CACXZuxeoG1v1y8Jm6kHSrFEad0WJo-kaoWk_QbWAM8hn1R_BwQ@mail.gmail.com>
 <20170907013101.f6d4eeftkolbsjr5@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f174.google.com ([209.85.217.174]:35964 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753927AbdIGKSL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 7 Sep 2017 06:18:11 -0400
Received: by mail-ua0-f174.google.com with SMTP id q29so15507792uaf.3
        for <linux-sparse@vger.kernel.org>; Thu, 07 Sep 2017 03:18:11 -0700 (PDT)
In-Reply-To: <20170907013101.f6d4eeftkolbsjr5@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 7 September 2017 at 02:31, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Thu, Sep 07, 2017 at 12:05:58AM +0100, Dibyendu Majumdar wrote:
>> I recently found another test case that fails:
>>
>> static int test_do(void) {
>>     int a = 0;
>>     int count = 27;
>>     switch (count % 8) {
>>     case 0: do {  a++;
>>     case 7:       a++;
>>     case 6:       a++;
>>     case 5:       a++;
>>     case 4:       a++;
>>     case 3:       a++;
>>     case 2:       a++;
>>     case 1:       a++;
>>             } while ((count -= 8) > 0);
>>     }
>>     if (27 != a) return 1;
>>     return 0;
>> }
>

What's interesting is that I find that this code compiles OK with the
old SSA implementation, with or without single store short-cut, and
with out without simplifications.

But the newssa implementation ( your original sssa-mini) fails when
simplifications are turned on.

Regards
Dibyendu

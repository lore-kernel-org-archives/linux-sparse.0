From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm op_fpcast implementation missing
Date: Sun, 12 Mar 2017 12:04:43 +0000
Message-ID: <CACXZuxcpYWZYy-XwbBWWS6si4cdfnxFXAHsthsAeMKijWZeNzg@mail.gmail.com>
References: <CACXZuxdZDSYP2j-8BJ6X_F9qpYWtdcVqZny06G_Qe0dkv_pOpw@mail.gmail.com>
 <20170312000126.zhnamtidjwdycvkg@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:37243 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755704AbdCLMFi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Mar 2017 08:05:38 -0400
Received: by mail-it0-f43.google.com with SMTP id g138so18468938itb.0
        for <linux-sparse@vger.kernel.org>; Sun, 12 Mar 2017 05:04:44 -0700 (PDT)
In-Reply-To: <20170312000126.zhnamtidjwdycvkg@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 12 March 2017 at 00:01, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sat, Mar 11, 2017 at 11:53:53PM +0000, Dibyendu Majumdar wrote:
>> Following test fails:
>>
>> int main(void)
>> {
>>  float f = 'a';
>>  float g = 97;
>>  printf("%f %f\n", f, g);
>>  return 0;
>> }
>
> Just for info, there is a lot of things missing or incorrect with
> floating-points and I'm not speaking of the llvm part but of
> sparse itself.
>
> I have some test cases somewhere in one of my topic branches
> but this is very very low priority to me.
>

Ok no problem. I have tried to add partial support for FPCAST and
SETVAL in my project. Here is the commit:

https://github.com/dibyendumajumdar/dmr_c/commit/b95d54c9555ccf9e230edea5c1a3701172b7b1e2

Please let me know if this looks reasonable.

Unfortunately due to my amended codebase I am not able to submit patches here.

Thanks and Regards
Dibyendu

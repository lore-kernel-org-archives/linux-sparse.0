From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm incorrect handling of function pointers
Date: Sat, 11 Mar 2017 11:56:05 +0000
Message-ID: <CACXZuxfB=2_hdG2XjZwtGzJH429s+1Xy_8JVF+e5Y3-HxMiCdg@mail.gmail.com>
References: <CACXZuxeHAXK11Tyx0PSg_uqDo0rZ3Cw+aZ5gN1S_LpPMZG8cCQ@mail.gmail.com>
 <20170310174445.4fmyibgvl7yyaz2s@macbook.local> <CACXZuxe9ioYu5fuZK=-iDdiL8RQpE37GvpE9s5DHjFYPCrKKfg@mail.gmail.com>
 <20170311115418.wwuvklkphmwfzom4@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:36002 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755348AbdCKL4H (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 06:56:07 -0500
Received: by mail-io0-f178.google.com with SMTP id l7so62383126ioe.3
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 03:56:06 -0800 (PST)
In-Reply-To: <20170311115418.wwuvklkphmwfzom4@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 11 March 2017 at 11:54, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Fri, Mar 10, 2017 at 06:13:16PM +0000, Dibyendu Majumdar wrote:
>> Yes, here is an amended test.
>>
>> static int testfunc(int i) {
>>  return i-6;
>> }
>> static int (*f) (int) = testfunc;
>> int main(int argc, const char *argv[]) {
>>  if (f) {
>>   return f(6);
>>  }
>>  else {
>>   return 1;
>>  }
>> }
>
> This one is because of the static initialization.
>

Yes, this works now:

static int testfunc(int i) {
 return i-6;
}
/* initialiser does not work */
/* static int (*f) (int) = testfunc */
static int (*f) (int);
int main(int argc, const char *argv[]) {
 f = testfunc;
 if (f) {
  return f(6);
 }
 else {
  return 1;
 }
}

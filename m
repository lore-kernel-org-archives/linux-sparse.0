From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm switch constants must all be same type as switch value
Date: Sun, 19 Mar 2017 12:31:27 +0000
Message-ID: <CACXZuxc3iC8jKFb-fE4SE=9ujOLK400sRFqH0z5ech4DHqfJ6A@mail.gmail.com>
References: <CACXZuxfOP79gJbOD=02pPYWV4HQbnN0tRVWup77_etBxvhjAAQ@mail.gmail.com>
 <20170319005245.os6jl436ajvqiyud@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:34346 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbdCSMcE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 08:32:04 -0400
Received: by mail-it0-f52.google.com with SMTP id y18so1361234itc.1
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 05:31:28 -0700 (PDT)
In-Reply-To: <20170319005245.os6jl436ajvqiyud@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 19 March 2017 at 00:52, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Mon, Mar 13, 2017 at 09:24:47PM +0000, Dibyendu Majumdar wrote:
>>
>> While investigating errors that occurred when compiling 'minilua' I
>> found that the sparse-llvm output for switch statements is hard coded
>> to generate int32 values even when the switch is on a different
>> integer type.
>
> Could you submit a test case for this?
>

extern int printf(const char *, ...);
int main(int argc, const char *argv[])
{
 const char *cp = argv[0];
 switch (*cp) {
 case 's':
  printf("%c\n", *cp);
  break;
 default:
  if (*cp)
   printf("%c\n", *cp);
  break;
 }
 return 0;
}

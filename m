From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm op_fpcast implementation missing
Date: Sun, 12 Mar 2017 20:49:40 +0100
Message-ID: <20170312194939.7xpggjpoki7uzs6o@macpro.local>
References: <CACXZuxdZDSYP2j-8BJ6X_F9qpYWtdcVqZny06G_Qe0dkv_pOpw@mail.gmail.com>
 <20170312000126.zhnamtidjwdycvkg@macbook.local>
 <CACXZuxcpYWZYy-XwbBWWS6si4cdfnxFXAHsthsAeMKijWZeNzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36183 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935269AbdCLTto (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Mar 2017 15:49:44 -0400
Received: by mail-wm0-f45.google.com with SMTP id n11so27194117wma.1
        for <linux-sparse@vger.kernel.org>; Sun, 12 Mar 2017 12:49:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxcpYWZYy-XwbBWWS6si4cdfnxFXAHsthsAeMKijWZeNzg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 12, 2017 at 12:04:43PM +0000, Dibyendu Majumdar wrote:
> On 12 March 2017 at 00:01, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > On Sat, Mar 11, 2017 at 11:53:53PM +0000, Dibyendu Majumdar wrote:
> >> Following test fails:
> >>
> >> int main(void)
> >> {
> >>  float f = 'a';
> >>  float g = 97;
> >>  printf("%f %f\n", f, g);
> >>  return 0;
> >> }
> >
> > Just for info, there is a lot of things missing or incorrect with
> > floating-points and I'm not speaking of the llvm part but of
> > sparse itself.
> >
> > I have some test cases somewhere in one of my topic branches
> > but this is very very low priority to me.
> >
> 
> Ok no problem. I have tried to add partial support for FPCAST and
> SETVAL in my project. Here is the commit:
> 
> https://github.com/dibyendumajumdar/dmr_c/commit/b95d54c9555ccf9e230edea5c1a3701172b7b1e2
> 
> Please let me know if this looks reasonable.

The idea is there, yes.
I just saw two minor things for OP_FPCAST:
- you consider all intergers as signed / there is no support for 
  unsigned integer to float (LLVMUIToFP I suppose).
- you're making the assumption sizeof(float) == 32, sizeof(double) == 64
  while these things are defined by the data layout

-- Luc Van Oostenryck

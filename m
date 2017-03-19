From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm switch constants must all be same type as switch
 value
Date: Sun, 19 Mar 2017 16:19:10 +0100
Message-ID: <20170319151909.w72zsjtl7uutsfvo@macpro.local>
References: <CACXZuxfOP79gJbOD=02pPYWV4HQbnN0tRVWup77_etBxvhjAAQ@mail.gmail.com>
 <20170319005245.os6jl436ajvqiyud@macpro.local>
 <CACXZuxc3iC8jKFb-fE4SE=9ujOLK400sRFqH0z5ech4DHqfJ6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37579 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751475AbdCSPTn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 11:19:43 -0400
Received: by mail-wm0-f48.google.com with SMTP id n11so47434832wma.0
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 08:19:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxc3iC8jKFb-fE4SE=9ujOLK400sRFqH0z5ech4DHqfJ6A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 19, 2017 at 12:31:27PM +0000, Dibyendu Majumdar wrote:
> On 19 March 2017 at 00:52, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > On Mon, Mar 13, 2017 at 09:24:47PM +0000, Dibyendu Majumdar wrote:
> >>
> >> While investigating errors that occurred when compiling 'minilua' I
> >> found that the sparse-llvm output for switch statements is hard coded
> >> to generate int32 values even when the switch is on a different
> >> integer type.

This is fixed in the llvm-fixes-v3 serie I submitted yesterday.

-- Luc

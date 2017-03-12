From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: dmr_C - a project based on Sparse that aims to create a JIT compiler
 for C
Date: Sun, 12 Mar 2017 18:21:37 +0000
Message-ID: <CACXZuxdQR-CRO2mUoh3kDcTbxx2Kx_PsoGb6vMT-FiBFVGSGjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:37974 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934142AbdCLSVj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Mar 2017 14:21:39 -0400
Received: by mail-it0-f54.google.com with SMTP id m27so20795865iti.1
        for <linux-sparse@vger.kernel.org>; Sun, 12 Mar 2017 11:21:38 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I am creating a JIT compiler for C building upon the Sparse library.
The project is hosted on GitHub (link below) and has the same license
as Sparse.

Initially I plan to build the backend by reusing the Sparse LLVM
backend hence my interest in making sure that it works correctly. But
in the long run, I would like a backend that is really compact - LLVM
is just too big a beast. I am currently considering nanojit as the
alternative backend.

I decided to use Sparse as a front-end as it seems to be fully
featured as a C front-end, and also does lot more than a simple
parser. The fact that it produces SSA IR is perfect for my needs. I
did not want to use a front-end such as Clang because of the sheer
size and complexity of Clang which results from supporting C++ and
Objective C. I want to build a relatively small and compact JIT engine
that doesn't have a lot of extra baggage.

To reuse Sparse as the JIT engine, I am making some changes to it.
Primarily I have removed (almost) all global state - as I needed the
ability to clean up all state after each compilation run, and serve
any number of requests within the same process instance. The other
changes are to do with making sure that Sparse can be compiled using
MSVC - so I had to change some of the gcc specific C features used in
Sparse.

The interest in a JIT engine for C arose from my attempt to create a
JIT compiler for the Lua language. I have coded this in LLVM but it is
too tedious to code and maintain. Being able to use a C based JIT will
make life much easier. Not only that it also makes it easier to switch
to a non-LLVM backend.

I think Sparse is an amazing project - so many thanks to you all for
creating it, and for making it available under MIT license.

Link to my project:

https://github.com/dibyendumajumdar/dmr_c

Thanks and Regards
Dibyendu

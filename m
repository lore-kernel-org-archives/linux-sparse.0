From: Blue Swirl <blauwirbel@gmail.com>
Subject: [PATCH 0/2] Fix sparc64 and x86_64 issues
Date: Wed, 5 Aug 2009 21:51:25 +0300
Message-ID: <f43fc5580908051151o560e73bdw50c3d575f50f7096@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:8631 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbZHESvp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 5 Aug 2009 14:51:45 -0400
Received: by fg-out-1718.google.com with SMTP id e21so86267fga.17
        for <linux-sparse@vger.kernel.org>; Wed, 05 Aug 2009 11:51:45 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

With these patches, I can run Sparse on OpenBIOS sources (which use
libgcc) also when compiling for 64 bit targets. 64 bit targets use 128
bit double cells, just like 64 bit double cells are used on 32 bit
targets.

I'm not sure if 'long long long' is actually used, libgcc uses
__attribute__ ((mode (TI))).

Blue Swirl (2):
  Add support for TImode type (__int128_t)
  Define __LP64__ for x86_64 unless in 32 bit mode

 cgcc         |    9 +++++----
 evaluate.c   |    8 +++++---
 expand.c     |    3 ++-
 gdbhelpers   |    3 +++
 parse.c      |   25 ++++++++++++++++++++++---
 show-parse.c |    3 +++
 symbol.c     |    6 ++++++
 symbol.h     |    8 +++++---
 target.c     |    1 +
 target.h     |    1 +
 10 files changed, 53 insertions(+), 14 deletions(-)

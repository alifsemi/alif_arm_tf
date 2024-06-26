#
# Copyright (c) 2019, ARM Limited and Contributors. All rights reserved.
#
# SPDX-License-Identifier: BSD-3-Clause
#

CORSTONE700_CPU_SOURCES	+=	lib/cpus/aarch32/cortex_a32.S

BL32_SOURCES		+=      plat/arm/board/corstone700/drivers/mhu/mhu.c

PLAT_INCLUDES		:=      -Iplat/arm/board/corstone700/include \
					-Iinclude/plat/arm/common/ \
					-Iplat/arm/board/corstone700/drivers/mhu/

NEED_BL32		:=	yes

CORSTONE700_GIC_SOURCES :=	drivers/arm/gic/common/gic_common.c     \
				drivers/arm/gic/v2/gicv2_main.c         \
				drivers/arm/gic/v2/gicv2_helpers.c      \
				plat/common/plat_gicv2.c                \
				plat/arm/common/arm_gicv2.c

# BL1/BL2 Image not a part of the capsule Image for corstone700
override NEED_BL1	:=	no
override NEED_BL2	:=	no
override NEED_BL2U	:=	no

#TFA for corstone700 starts from BL32
override RESET_TO_SP_MIN	:=	1

#Device tree
CORSTONE700_HW_CONFIG_DTS   :=      fdts/corstone700.dts

CORSTONE700_HW_CONFIG       :=      ${BUILD_PLAT}/fdts/${PLAT}.dtb

FDT_SOURCES		    +=      ${CORSTONE700_HW_CONFIG_DTS}
$(eval CORSTONE700_HW_CONFIG     :=      ${BUILD_PLAT}/$(patsubst %.dts,%.dtb,$(CORSTONE700_HW_CONFIG_DTS)))

# Add the HW_CONFIG to FIP and specify the same to certtool
$(eval $(call TOOL_ADD_PAYLOAD,${CORSTONE700_HW_CONFIG},--hw-config))

include plat/arm/board/common/board_common.mk
include plat/arm/common/arm_common.mk
